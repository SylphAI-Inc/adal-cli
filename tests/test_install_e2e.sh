#!/usr/bin/env bash
# End-to-end installer tests against a local file:// release layout.
#
# These exercise the full download -> manifest-schema -> checksum ->
# signature -> extract -> symlink pipeline, plus opt-in tracking with an
# HMAC-signed payload captured by a local HTTP server.
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/install.sh"

# shellcheck disable=SC1091
source "$(dirname "$0")/lib.sh"

command -v minisign >/dev/null 2>&1 || { echo "SKIP: minisign not installed (brew install minisign)"; exit 0; }
command -v python3 >/dev/null 2>&1 || { echo "SKIP: python3 not installed"; exit 0; }

WORK=$(mktemp -d)
LAYOUT="$WORK/releases"
SIGN="$WORK/sign"
mkdir -p "$LAYOUT/manifests" "$LAYOUT/0.9.0" "$SIGN"

VERSION="0.9.0"
PLATFORM="darwin-arm64"
ARCHIVE="adal-$VERSION-$PLATFORM.tar.gz"

cleanup() { [ -n "${CAP_PID:-}" ] && kill "$CAP_PID" 2>/dev/null; rm -rf "$WORK"; }
trap cleanup EXIT

# ---- helpers ---------------------------------------------------------------
file_size() {
  if [[ "$(uname -s)" == "Darwin" ]]; then stat -f%z "$1"; else stat -c%s "$1"; fi
}

# Build the fake release payload (a tarball that would legitimately extract)
build_payload() {
  local payload_dir="$WORK/payload/adal-$VERSION"
  rm -rf "$WORK/payload"
  mkdir -p "$payload_dir"
  echo 'console.log("adal stub")' > "$payload_dir/adal-cli.js"
  cat > "$payload_dir/adal" <<'STUB'
#!/usr/bin/env bash
echo "adal test stub $VERSION"
STUB
  chmod +x "$payload_dir/adal"
  tar -czf "$LAYOUT/$VERSION/$ARCHIVE" -C "$WORK/payload" "adal-$VERSION"
}

# Regenerate manifest from the current tarball (uses real checksum/size)
write_manifest() {
  local checksum
  checksum=$(shasum -a 256 "$LAYOUT/$VERSION/$ARCHIVE" | cut -d' ' -f1)
  local size
  size=$(file_size "$LAYOUT/$VERSION/$ARCHIVE")
  printf '{"version":"%s","channel":"latest","date":"2026-01-01T00:00:00Z","platforms":{"%s":{"filename":"%s","checksum":"%s","size":%s}}}\n' \
    "$VERSION" "$PLATFORM" "$ARCHIVE" "$checksum" "$size" \
    > "$LAYOUT/manifests/manifest-$VERSION.json"
}

# Generate a throwaway signing keypair and export the public key to the installer
setup_signing() {
  minisign -G -W -s "$SIGN/mini.key" -p "$SIGN/mini.pub" >/dev/null 2>&1
  # The installer accepts ADAL_SIGNING_PUBLIC_KEY override so tests can use a
  # throwaway key instead of the production one embedded in install.sh.
  export ADAL_SIGNING_PUBLIC_KEY
  ADAL_SIGNING_PUBLIC_KEY=$(tail -1 "$SIGN/mini.pub")
}

sign_archive() {
  minisign -S -s "$SIGN/mini.key" -m "$LAYOUT/$VERSION/$ARCHIVE" -x "$LAYOUT/$VERSION/$ARCHIVE.minisig" >/dev/null 2>&1
}

# Run the installer with a FRESH home unless TEST_HOME is set.
# EXTRA_ENV may carry additional KEY=VAL pairs.
run_install() {
  local home_dir="${TEST_HOME:-$WORK/home-$$-$RANDOM}"
  mkdir -p "$home_dir"
  # shellcheck disable=SC2086
  env HOME="$home_dir" ADAL_RELEASES_URL="file://$LAYOUT" ADAL_TRACK_URL="${TRACK_URL:-}" ${EXTRA_ENV:-} \
    bash "$SRC" --no-modify-path "$@" 2>&1
  echo "EXIT_CODE:$?"
}

exit_code_of() { echo "$1" | sed -n 's/^EXIT_CODE:\([0-9]*\)$/\1/p' | tail -1; }

assert_exit() { # expected_code, output
  local code
  code=$(exit_code_of "$2")
  if [ "$code" = "$1" ]; then ok; else fail "expected exit $1, got $code"; echo "$2" | sed 's/^/       | /' | tail -25 >&2; fi
}

# ---- fixture setup ---------------------------------------------------------
setup_signing
build_payload
write_manifest
sign_archive
echo -n "$VERSION" > "$LAYOUT/latest"
echo -n "$VERSION" > "$LAYOUT/beta"

echo "== happy path: signed release installs =="
t "install v$VERSION with valid signature + checksum"
H="$WORK/happy-home"; mkdir -p "$H"
OUT=$(TEST_HOME="$H" run_install --version "$VERSION" --no-track)
assert_exit 0 "$OUT"
assert_contains "$OUT" "Ed25519 signature verified"
assert_file "$H/.adal/bin/adal"
assert_exec "$H/.adal/versions/$VERSION/adal"
assert_file "$H/.adal/versions/$VERSION/adal-cli.js"

t "reinstall (already installed) is a no-op success"
OUT=$(TEST_HOME="$H" run_install --version "$VERSION" --no-track)
assert_exit 0 "$OUT"
assert_contains "$OUT" "already installed"

echo ""
echo "== tamper detection =="

t "tampered tarball -> integrity check fails"
printf 'X' >> "$LAYOUT/$VERSION/$ARCHIVE"
OUT=$(run_install --version "$VERSION" --no-track)
assert_nonzero "$(exit_code_of "$OUT")"
# Size check fires before checksum; either message is the correct protection
assert_contains "$OUT" "Error:"
assert_not_contains "$OUT" "installed!"
build_payload && write_manifest && sign_archive

t "tampered tarball + forged manifest checksum -> signature fails"
printf 'X' >> "$LAYOUT/$VERSION/$ARCHIVE"
write_manifest   # manifest now matches the tampered file, but the .minisig does not
OUT=$(run_install --version "$VERSION" --no-track)
assert_nonzero "$(exit_code_of "$OUT")"
assert_contains "$OUT" "Signature verification failed"
build_payload && write_manifest && sign_archive

echo ""
echo "== signature availability modes =="

t "missing .minisig -> transition warning, install proceeds"
rm -f "$LAYOUT/$VERSION/$ARCHIVE.minisig"
OUT=$(run_install --version "$VERSION" --no-track)
assert_exit 0 "$OUT"
assert_contains "$OUT" "No signature published"
sign_archive

t "missing .minisig + ADAL_REQUIRE_SIGNATURE=1 -> hard fail"
rm -f "$LAYOUT/$VERSION/$ARCHIVE.minisig"
OUT=$(EXTRA_ENV="ADAL_REQUIRE_SIGNATURE=1" run_install --version "$VERSION" --no-track)
assert_nonzero "$(exit_code_of "$OUT")"
assert_contains "$OUT" "Signature file missing"
sign_archive

echo ""
echo "== manifest schema validation =="

t "malformed manifest (missing checksum) -> hard fail"
printf '{"version":"%s","platforms":{"%s":{"filename":"%s","size":123}}}\n' "$VERSION" "$PLATFORM" "$ARCHIVE" \
  > "$LAYOUT/manifests/manifest-$VERSION.json"
OUT=$(run_install --version "$VERSION" --no-track)
assert_nonzero "$(exit_code_of "$OUT")"
assert_contains "$OUT" "checksum"
write_manifest

t "manifest with wrong filename -> hard fail"
printf '{"version":"%s","platforms":{"%s":{"filename":"evil.tar.gz","checksum":"%064d","size":1}}}\n' "$VERSION" "$PLATFORM" 0 \
  > "$LAYOUT/manifests/manifest-$VERSION.json"
OUT=$(run_install --version "$VERSION" --no-track)
assert_nonzero "$(exit_code_of "$OUT")"
assert_contains "$OUT" "does not match expected"
write_manifest

echo ""
echo "== version resolution =="

t "channel resolution (--version beta) installs resolved version"
OUT=$(run_install --version beta --no-track)
assert_exit 0 "$OUT"
assert_contains "$OUT" "Resolving channel 'beta'"

t "latest resolution (no --version) installs latest"
OUT=$(run_install --no-track)
assert_exit 0 "$OUT"
assert_contains "$OUT" "Checking for latest version"

t "invalid version string rejected"
OUT=$(run_install --version "../etc/passwd" --no-track)
assert_nonzero "$(exit_code_of "$OUT")"
assert_contains "$OUT" "Invalid version format"

echo ""
echo "== tracking (opt-in + HMAC) =="

TRACK_LOG="$WORK/captured.log"
PORT_FILE="$WORK/port"
python3 "$ROOT/tests/capture_server.py" "$TRACK_LOG" "$PORT_FILE" >/dev/null 2>&1 &
CAP_PID=$!
for _ in $(seq 1 50); do [ -s "$PORT_FILE" ] && break; sleep 0.1; done
TRACK_URL="http://127.0.0.1:$(cat "$PORT_FILE")/api/installs/track"
export TRACK_URL

t "default: tracking OFF — no request is sent"
OUT=$(run_install --version "$VERSION")
assert_exit 0 "$OUT"
sleep 1
[ -s "$TRACK_LOG" ] && fail "tracking request was sent despite opt-in default" || ok

t "--track: POST sent with HMAC signature + ts + nonce"
OUT=$(run_install --version "$VERSION" --track)
assert_exit 0 "$OUT"
sleep 1
assert_file "$TRACK_LOG"
LOG=$(cat "$TRACK_LOG")
assert_contains "$LOG" "X-Adal-Signature:"
assert_contains "$LOG" "X-Adal-Ts:"
assert_contains "$LOG" "X-Adal-Nonce:"
assert_contains "$LOG" '"channel":"stable"'

t "HMAC-SHA256 signature matches body (computed independently)"
BODY=$(grep '^BODY:' "$TRACK_LOG" | tail -1 | sed 's/^BODY: //')
SIG=$(grep '^X-Adal-Signature:' "$TRACK_LOG" | tail -1 | cut -d' ' -f2)
EXPECTED=$(printf '%s' "$BODY" | openssl dgst -sha256 -hmac "adal-cli-install-track-v1" 2>/dev/null | awk '{print $NF}')
assert_eq "$SIG" "$EXPECTED"

t "--no-track overrides ADAL_TRACK=1"
: > "$TRACK_LOG"
OUT=$(EXTRA_ENV="ADAL_TRACK=1" run_install --version "$VERSION" --no-track)
sleep 1
[ -s "$TRACK_LOG" ] && fail "request sent despite --no-track" || ok

kill "$CAP_PID" 2>/dev/null
CAP_PID=""

finish