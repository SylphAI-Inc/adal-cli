#!/usr/bin/env bash
set -euo pipefail

# AdaL CLI Installer v2 (hardened)
# Usage: curl -fsSL https://adal.sylph.ai/install.sh | bash                              # latest stable
#        curl -fsSL https://adal.sylph.ai/install.sh | bash -s -- --version beta           # latest beta
#        curl -fsSL https://adal.sylph.ai/install.sh | bash -s -- --version 1.0.2-beta.1   # specific version
#
# Installs to ~/.adal/versions/<version>/ with symlink at ~/.adal/bin/adal
# Supports: macOS (arm64/x64), Linux (x64/arm64), Windows (x64 via Git Bash)
#
# Hardening vs upstream:
#   * minisign (Ed25519) artifact signature verification with embedded public key
#     - enforced when a .minisig file is published; transition mode warns otherwise
#     - ADAL_REQUIRE_SIGNATURE=1 forces hard failure when signing is unavailable
#   * Manifest schema validation (version / platforms.<platform>.checksum|size|filename)
#     before anything is trusted
#   * JSON parsing via jq -> python3 -> sed fallback (was sed-only)
#   * Version string validated against semver regex before use in URLs
#   * Local tarball filename validated against strict regex (blocks command injection)
#   * Hard failure when the manifest/checksum is unavailable (no silent skip)
#   * EXIT trap cleans the temp dir on error/signal
#   * Extraction verified against the real entry point (adal / adal.cmd)
#   * Install tracking is OPT-IN: requires ADAL_TRACK=1 or --track
#     - requests carry an HMAC-SHA256 signature + timestamp + nonce
#   * RELEASES_URL / TRACK_URL are env-overridable for mirrors and testing
#   * Fixed 2>/devuhl typo -> 2>/dev/null

APP="adal"
RELEASES_URL="${ADAL_RELEASES_URL:-https://d35qg8ac0yw4p7.cloudfront.net/cli}"
TRACK_URL="${ADAL_TRACK_URL:-https://adal.sylph.ai/api/installs/track}"
# HMAC secret used to sign tracking payloads. This is obfuscation, not auth:
# it is embedded in a public installer, so the server must not treat it as
# proof of identity — only as a filter for accidental/naive abuse. See RELEASE.md
# for the server-side verification reference.
TRACK_HMAC_SECRET="${ADAL_TRACK_HMAC_SECRET:-adal-cli-install-track-v1}"

# minisign public key for artifact verification.
# Generate/rotate with: minisign -G -s adal-release.minisign -p adal-release.pub
#   - Private key: keep OUT of the repo, in CI secrets or a secrets manager.
#   - Public key:  this value (RWT...).
# ADAL_SIGNING_PUBLIC_KEY override exists so the test suite can verify against
# a throwaway keypair.
SIGNING_PUBLIC_KEY="${ADAL_SIGNING_PUBLIC_KEY:-RWTpQA9INHbbcb1MHIInAuhmJRnFaOn4Bf+Ye8oftDSkWK/SrYakIH3m}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
MUTED='\033[0;2m'
NC='\033[0m'

# ┌─ Parse arguments ──────────────────────────────────────────────────────────────

usage() {
  cat <<EOF
AdaL CLI Installer

Usage:
  curl -fsSL https://adal.sylph.ai/install.sh | bash
  curl -fsSL https://adal.sylph.ai/install.sh | bash -s -- [OPTIONS]

Options:
  -v, --version <VER>   Install a specific version (e.g., 0.6.0-beta.1)
  --local-tarball <PATH> Install from a local native tarball (skip download)
  --no-modify-path      Don't modify shell config files (.zshrc, .bashrc, etc.)
  --track               Opt in to anonymous install tracking (default: off)
  --no-track            Disable tracking even if ADAL_TRACK=1 is set
  -h, --help            Show this help message

Environment:
  ADAL_NO_TRACK=1           Disable tracking
  ADAL_TRACK=1              Opt in to tracking (equivalent to --track)
  ADAL_REQUIRE_SIGNATURE=1  Fail hard if a release has no minisign signature
  ADAL_RELEASES_URL=...     Override the release base URL (mirrors/testing)
EOF
}

requested_version=""
no_modify_path=false
local_tarball=""
track_opt_in=false
no_track=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    -v|--version)
      if [[ -n "${2:-}" ]]; then
        requested_version="$2"; shift 2
      else
        echo -e "${RED}Error: --version requires a version argument${NC}" >&2; exit 1
      fi ;;
    --no-modify-path) no_modify_path=true; shift ;;
    --track) track_opt_in=true; shift ;;
    --no-track) no_track=true; shift ;;
    --local-tarball)
      if [[ -n "${2:-}" ]]; then
        local_tarball="$2"; shift 2
      else
        echo -e "${RED}Error: --local-tarball requires a path argument${NC}" >&2; exit 1
      fi ;;
    *) echo -e "${YELLOW}Warning: Unknown option '$1'${NC}" >&2; shift ;;
  esac
done

# ┌─ Platform detection ────────────────────────────────────────────────────────────

detect_platform() {
  local raw_os
  raw_os=$(uname -s)

  case "$raw_os" in
    Darwin*)          os="darwin" ;;
    Linux*)           os="linux" ;;
    MINGW*|MSYS*|CYGWIN*) os="win32" ;;
    *)
      echo -e "${RED}Unsupported operating system: $raw_os${NC}" >&2
      echo -e "${MUTED}AdaL supports macOS, Linux, and Windows (via Git Bash).${NC}" >&2
      exit 1 ;;
  esac

  local raw_arch
  raw_arch=$(uname -m)

  case "$raw_arch" in
    x86_64|amd64)   arch="x64" ;;
    arm64|aarch64)   arch="arm64" ;;
    *)
      echo -e "${RED}Unsupported architecture: $raw_arch${NC}" >&2
      exit 1 ;;
  esac

  # Detect Rosetta 2: if running x64 under emulation on ARM Mac, use arm64
  if [ "$os" = "darwin" ] && [ "$arch" = "x64" ]; then
    if [ "$(sysctl -n sysctl.proc_translated 2>/dev/null)" = "1" ]; then
      arch="arm64"
      echo -e "${MUTED}Detected Rosetta 2 — using native arm64 binary${NC}"
    fi
  fi

  # Detect musl (Alpine Linux)
  is_musl=false
  if [ "$os" = "linux" ]; then
    if [ -f /etc/alpine-release ]; then
      is_musl=true
    elif command -v ldd >/dev/null 2>&1; then
      if ldd --version 2>&1 | grep -qi musl; then
        is_musl=true
      fi
    fi
  fi

  PLATFORM="${os}-${arch}"

  # On musl-libc Linux (Alpine and similar), pick the musl-native tarball
  # instead of the glibc one — glibc binaries (including the bundled Bun
  # runtime) cannot load when /lib64/ld-linux-x86-64.so.2 is absent.
  if [ "$is_musl" = true ] && [ "$os" = "linux" ]; then
    PLATFORM="${PLATFORM}-musl"
    echo -e "${MUTED}Detected musl libc (Alpine and similar) — using ${PLATFORM} tarball${NC}"
  fi

  # Validate platform is supported.
  case "$PLATFORM" in
    darwin-arm64|darwin-x64|linux-x64|linux-x64-musl|linux-arm64|win32-x64) ;;
    *)
      echo -e "${RED}Unsupported platform: $PLATFORM${NC}" >&2
      echo -e "${MUTED}Supported: macOS (arm64/x64), Linux (x64 glibc/musl, arm64 glibc), Windows (x64)${NC}" >&2
      if [ "$PLATFORM" = "linux-arm64-musl" ]; then
        echo -e "${MUTED}Note: linux-arm64-musl builds are not published yet.${NC}" >&2
        echo -e "${MUTED}Workaround: install the glibc build under a musl-compatible runtime, or open an issue on https://github.com/SylphAI-Inc/adal-cli${NC}" >&2
      fi
      exit 1 ;;
  esac
}

# ┌─ musl runtime deps ────────────────────────────────────────────────────────────

# Bun in the musl tarball is dynamically linked against libstdc++ and libgcc_s
# (Bun's C++ runtime + GCC's unwinder). Slim Alpine base images (including
# python:3.11-alpine, alpine:3.x, and most SWE-bench Alpine variants) don't
# ship these by default — exec'ing adal then prints a flood of "Error
# loading shared library libstdc++.so.6 / libgcc_s.so.1" messages. Install
# them via apk before extracting the tarball.
ensure_musl_runtime_deps() {
  [ "$is_musl" = true ] || return 0
  [ "$os" = "linux" ] || return 0

  # Skip if both libs are already present.
  if ldconfig -p 2>/dev/null | grep -q libstdc++.so.6 && \
     ldconfig -p 2>/dev/null | grep -q libgcc_s.so.1; then
    return 0
  fi
  if [ -f /usr/lib/libstdc++.so.6 ] && [ -f /usr/lib/libgcc_s.so.1 ]; then
    return 0
  fi

  if ! command -v apk >/dev/null 2>&1; then
    echo -e "${YELLOW}musl detected but apk is not available; cannot auto-install libstdc++/libgcc.${NC}" >&2
    echo -e "${MUTED}Please install them manually before running adal.${NC}" >&2
    return 0
  fi

  echo -e "${MUTED}Installing libstdc++ and libgcc (required by bundled Bun runtime)...${NC}"
  if [ "$(id -u 2>/dev/null)" = "0" ]; then
    apk add --no-cache libstdc++ libgcc >/dev/null 2>&1 || \
      echo -e "${YELLOW}apk add libstdc++ libgcc failed; adal may not start.${NC}" >&2
  elif command -v sudo >/dev/null 2>&1; then
    sudo apk add --no-cache libstdc++ libgcc >/dev/null 2>&1 || \
      echo -e "${YELLOW}sudo apk add libstdc++ libgcc failed; adal may not start.${NC}" >&2
  else
    echo -e "${YELLOW}Not running as root and sudo not available — please run: apk add libstdc++ libgcc${NC}" >&2
  fi
}

# ┌─ Download helpers ────────────────────────────────────────────────────────────

DOWNLOADER=""
detect_downloader() {
  if command -v curl >/dev/null 2>&1; then
    DOWNLOADER="curl"
  elif command -v wget >/dev/null 2>&1; then
    DOWNLOADER="wget"
  else
    echo -e "${RED}Either curl or wget is required but neither is installed${NC}" >&2
    exit 1
  fi
}

download_file() {
  local url="$1"
  local output="${2:-}"

  if [ "$DOWNLOADER" = "curl" ]; then
    if [ -n "$output" ]; then
      curl -fsSL -o "$output" "$url"
    else
      curl -fsSL "$url"
    fi
  elif [ "$DOWNLOADER" = "wget" ]; then
    if [ -n "$output" ]; then
      wget -q -O "$output" "$url"
    else
      wget -q -O - "$url"
    fi
  fi
}

download_with_progress() {
  local url="$1"
  local output="$2"
  local expected_size="$3"  # optional, in bytes

  # Start download in background
  if [ "$DOWNLOADER" = "curl" ]; then
    curl -fsSL -o "$output" "$url" &
  elif [ "$DOWNLOADER" = "wget" ]; then
    wget -q -O "$output" "$url" &
  fi
  local dl_pid=$!

  # Show progress if we know the expected size
  if [ -n "$expected_size" ] && [ "$expected_size" -gt 0 ] 2>/dev/null; then
    local last_pct=-1
    while kill -0 "$dl_pid" 2>/dev/null; do
      if [ -f "$output" ]; then
        local current_size
        if [[ "$(uname -s)" == "Darwin" ]]; then
          current_size=$(stat -f%z "$output" 2>/dev/null || echo 0)
        else
          current_size=$(stat -c%s "$output" 2>/dev/null || echo 0)
        fi
        local pct=$((current_size * 100 / expected_size))
        [ "$pct" -gt 100 ] && pct=100
        if [ "$pct" -ne "$last_pct" ]; then
          printf "\r${MUTED}🌸 Installing ${NC}${APP} ${MUTED}v${VERSION} (%d%%)${NC}" "$pct" >&2
          last_pct=$pct
        fi
      fi
      sleep 0.5
    done
    printf "\r${MUTED}🌸 Installing ${NC}${APP} ${MUTED}v${VERSION} (100%%)${NC}\n" >&2
  fi

  wait "$dl_pid"
  return $?
}

# ┌─ Checksum verification ──────────────────────────────────────────────────────────

verify_checksum() {
  local file="$1"
  local expected="$2"

  local actual
  if command -v shasum >/dev/null 2>&1; then
    actual=$(shasum -a 256 "$file" | cut -d' ' -f1)
  elif command -v sha256sum >/dev/null 2>&1; then
    actual=$(sha256sum "$file" | cut -d' ' -f1)
  else
    echo -e "${YELLOW}Warning: Cannot verify checksum (no shasum or sha256sum)${NC}" >&2
    return 0
  fi

  if [ "$actual" != "$expected" ]; then
    echo -e "${RED}Checksum verification failed!${NC}" >&2
    echo -e "${MUTED}  Expected: $expected${NC}" >&2
    echo -e "${MUTED}  Actual:   $actual${NC}" >&2
    return 1
  fi
}

# ┌─ Signature verification (minisign / Ed25519) ───────────────────────────────────

# Verify the artifact against its detached .minisig signature and the embedded
# public key. Transition mode: while the release pipeline does not yet publish
# .minisig files, a missing signature warns but does not fail; once signatures
# are published they are ALWAYS enforced (a bad signature is a hard failure).
# Set ADAL_REQUIRE_SIGNATURE=1 to fail hard when signing is unavailable.
verify_signature() {
  local file="$1"
  local sig_file="$2"
  local public_key="$3"

  if ! command -v minisign >/dev/null 2>&1; then
    if [ "${ADAL_REQUIRE_SIGNATURE:-0}" = "1" ]; then
      echo -e "${RED}Error: ADAL_REQUIRE_SIGNATURE=1 requires minisign (brew install minisign / apt install minisign)${NC}" >&2
      exit 1
    fi
    echo -e "  ${YELLOW}⚠ minisign not installed — skipping signature verification (SHA256 still enforced)${NC}"
    return 0
  fi

  if [ ! -s "$sig_file" ]; then
    if [ "${ADAL_REQUIRE_SIGNATURE:-0}" = "1" ]; then
      echo -e "${RED}Error: Signature file missing: $sig_file${NC}" >&2
      exit 1
    fi
    echo -e "  ${YELLOW}⚠ No signature published for this release yet — relying on SHA256 checksum${NC}"
    return 0
  fi

  if ! minisign -Vm "$file" -P "$public_key" -x "$sig_file" >/dev/null 2>&1; then
    echo -e "${RED}Signature verification failed!${NC}" >&2
    echo -e "${MUTED}  File:      $file${NC}" >&2
    echo -e "${MUTED}  Signature: $sig_file${NC}" >&2
    return 1
  fi
  echo -e "  ${GREEN}✅ Ed25519 signature verified${NC}"
  return 0
}

# ┌─ JSON parsing (jq -> python3 -> sed fallback) ─────────────────────────────────

# Extract a string value from JSON: json_get '{"key":"val"}' "key" → val
json_get() {
  local json="$1"
  local key="$2"

  if command -v jq >/dev/null 2>&1; then
    echo "$json" | jq -r --arg k "$key" '
      .[$k] // empty | if type == "string" then . else tostring end
    ' 2>/dev/null || true
  elif command -v python3 >/dev/null 2>&1; then
    echo "$json" | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
    v = d.get(sys.argv[1])
    if v is not None:
        print(v)
except Exception:
    pass
' "$key" 2>/dev/null || true
  else
    echo "$json" | sed -n "s/.*\"$key\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" | head -1
  fi
}

# Extract a number value from JSON
json_get_num() {
  local json="$1"
  local key="$2"

  if command -v jq >/dev/null 2>&1; then
    echo "$json" | jq -r --arg k "$key" '
      .[$k] | if type == "number" then tostring else empty end
    ' 2>/dev/null || true
  elif command -v python3 >/dev/null 2>&1; then
    echo "$json" | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
    v = d.get(sys.argv[1])
    if isinstance(v, (int, float)):
        print(v)
except Exception:
    pass
' "$key" 2>/dev/null || true
  else
    echo "$json" | sed -n "s/.*\"$key\"[[:space:]]*:[[:space:]]*\([0-9]*\).*/\1/p" | head -1
  fi
}

# Extract a platform block from manifest JSON.
# The manifest nests platforms under a "platforms" key ({"platforms": {...}});
# also tolerate top-level placement for forward compatibility.
json_get_platform() {
  local json="$1"
  local platform="$2"

  if command -v jq >/dev/null 2>&1; then
    echo "$json" | jq -c --arg p "$platform" '(.platforms[$p] // .[$p]) // empty' 2>/dev/null || true
  elif command -v python3 >/dev/null 2>&1; then
    echo "$json" | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
    v = d.get("platforms", {}).get(sys.argv[1]) or d.get(sys.argv[1])
    if isinstance(v, dict):
        print(json.dumps(v))
except Exception:
    pass
' "$platform" 2>/dev/null || true
  else
    echo "$json" | tr -d '\n' | sed -n "s/.*\"$platform\"[[:space:]]*:[[:space:]]*{\([^}]*\)}.*/\1/p"
  fi
}

# ┌─ Manifest schema validation ────────────────────────────────────────────────────

# Validate that the manifest has the expected shape before trusting any value.
# Returns 0 with CHECKSUM/SIZE populated via echo, 1 on schema failure.
parse_manifest() {
  local manifest="$1"
  local version="$2"
  local platform="$3"
  local expected_filename="$4"

  # version must be a string and match the requested version
  local mver
  mver=$(json_get "$manifest" "version")
  if [ -z "$mver" ]; then
    echo -e "${RED}Error: Manifest missing 'version' field${NC}" >&2
    return 1
  fi
  if [ "$mver" != "$version" ]; then
    echo -e "${YELLOW}Warning: manifest version '$mver' does not match requested '$version'${NC}" >&2
  fi

  # platform block must exist
  local block
  block=$(json_get_platform "$manifest" "$platform")
  if [ -z "$block" ]; then
    echo -e "${RED}Error: Manifest has no entry for platform '$platform'${NC}" >&2
    return 1
  fi

  # checksum must be 64 hex chars
  local checksum
  checksum=$(json_get "$block" "checksum")
  if [ -z "$checksum" ] || ! echo "$checksum" | grep -qE '^[a-fA-F0-9]{64}$'; then
    echo -e "${RED}Error: Manifest platform '$platform' has invalid/missing 'checksum' (expected 64 hex chars)${NC}" >&2
    return 1
  fi

  # size must be a positive integer
  local size
  size=$(json_get_num "$block" "size")
  if [ -z "$size" ] || ! echo "$size" | grep -qE '^[0-9]+$' || [ "$size" -le 0 ] 2>/dev/null; then
    echo -e "${RED}Error: Manifest platform '$platform' has invalid/missing 'size'${NC}" >&2
    return 1
  fi

  # filename must match what we are about to download
  local fname
  fname=$(json_get "$block" "filename")
  if [ -n "$fname" ] && [ "$fname" != "$expected_filename" ]; then
    echo -e "${RED}Error: Manifest filename '$fname' does not match expected '$expected_filename'${NC}" >&2
    return 1
  fi

  echo "$checksum"
  echo "$size"
  return 0
}

# ┌─ Version validation ────────────────────────────────────────────────────────────

# Strict semver check — blocks path traversal / injection via the version string,
# which is interpolated into download URLs below.
validate_version() {
  local ver="$1"
  if ! echo "$ver" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*)?$'; then
    echo -e "${RED}Error: Invalid version format: $ver${NC}" >&2
    echo -e "${MUTED}Expected semver like 1.2.3 or 1.2.3-beta.1${NC}" >&2
    exit 1
  fi
}

# ┌─ Version resolution ────────────────────────────────────────────────────────────

resolve_version() {
  if [ -n "$requested_version" ]; then
    # Strip leading 'v' if present
    requested_version="${requested_version#v}"
    VERSION="$requested_version"

    # Support channel names (e.g., "beta") — resolve to actual version number
    if echo "$VERSION" | grep -qE '^[a-z]+$'; then
      echo -e "${MUTED}Resolving channel '$VERSION'...${NC}"
      local resolved
      resolved=$(download_file "$RELEASES_URL/$VERSION" 2>/dev/null | tr -d '[:space:]')
      if [ -z "$resolved" ]; then
        echo -e "${RED}Error: Channel '${VERSION}' not found${NC}" >&2
        exit 1
      fi
      VERSION="$resolved"
      validate_version "$VERSION"
    else
      validate_version "$VERSION"
      # Verify the version exists on S3 by checking the manifest
      local http_status
      if [ "$DOWNLOADER" = "curl" ]; then
        http_status=$(curl -sI -o /dev/null -w "%{http_code}" "$RELEASES_URL/manifests/manifest-${VERSION}.json")
      else
        http_status=$(wget --spider -S "$RELEASES_URL/manifests/manifest-${VERSION}.json" 2>&1 | grep "HTTP/" | tail -1 | awk '{print $2}')
      fi

      if [ "$http_status" = "404" ] || [ "$http_status" = "403" ]; then
        echo -e "${RED}Error: Version ${VERSION} not found${NC}" >&2
        exit 1
      fi
    fi
  else
    # Fetch latest version from S3 channel pointer file
    echo -e "${MUTED}Checking for latest version...${NC}"
    VERSION=$(download_file "$RELEASES_URL/latest" 2>/dev/null | tr -d '[:space:]')

    if [ -z "$VERSION" ]; then
      echo -e "${RED}Failed to determine latest version${NC}" >&2
      exit 1
    fi
    validate_version "$VERSION"
  fi
}

# ┌─ Check existing installation ────────────────────────────────────────────────────

INSTALL_BASE="$HOME/.adal"
VERSIONS_DIR="$INSTALL_BASE/versions"
BIN_DIR="$INSTALL_BASE/bin"

check_existing() {
  if [ -d "$VERSIONS_DIR/$VERSION" ]; then
    echo -e "${MUTED}Version $VERSION is already installed${NC}"
    # Still update symlinks and PATH in case they're broken or missing.
    setup_symlinks
    cleanup_old_versions
    setup_path
    setup_github_actions_path
    detect_npm_install
    print_success
    exit 0
  fi
}

# ┌─ Local tarball install ──────────────────────────────────────────────────────────

install_from_local_tarball() {
  local tarball="$1"

  if [ ! -f "$tarball" ]; then
    echo -e "${RED}Error: Local tarball not found: $tarball${NC}" >&2
    exit 1
  fi

  # Extract version from tarball filename: adal-<VERSION>-<PLATFORM>.tar.gz
  local basename_tar
  basename_tar=$(basename "$tarball")

  # Strict filename validation — blocks command injection via crafted filenames
  # (e.g. adal-1.0.0-$(reboot)-linux-x64.tar.gz) before any parsing.
  if ! [[ "$basename_tar" =~ ^adal-[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*)?-(darwin|linux|win32)-(x64|arm64)(-musl)?\.(tar\.gz|zip)$ ]]; then
    echo -e "${RED}Error: Invalid tarball filename: $basename_tar${NC}" >&2
    echo -e "${MUTED}Expected format: adal-<VERSION>-<PLATFORM>.tar.gz (e.g. adal-1.2.3-linux-x64-musl.tar.gz)${NC}" >&2
    exit 1
  fi

  # Strip extension (.tar.gz or .zip)
  local stem="${basename_tar%.tar.gz}"
  stem="${stem%.zip}"
  # Extract version: adal-<VERSION>-<PLATFORM> → strip "adal-" prefix, then strip "-<PLATFORM>" suffix
  VERSION=$(echo "$stem" | sed 's/^adal-//; s/-\(darwin\|linux\|win32\)-.*$//')

  if [ -z "$VERSION" ]; then
    echo -e "${RED}Error: Cannot determine version from tarball filename: $basename_tar${NC}" >&2
    echo -e "${MUTED}Expected format: adal-<VERSION>-<PLATFORM>.tar.gz${NC}" >&2
    exit 1
  fi

  printf "\n${MUTED}🌸 Installing ${NC}${APP} ${MUTED}v${VERSION} (from local tarball)${NC}\n"

  # Extract
  mkdir -p "$VERSIONS_DIR"
  tar -xzf "$tarball" -C "$VERSIONS_DIR"

  # The tarball extracts to adal-<version>/ — rename to just <version>/
  if [ -d "$VERSIONS_DIR/adal-$VERSION" ]; then
    rm -rf "${VERSIONS_DIR:?}/$VERSION"
    mv "$VERSIONS_DIR/adal-$VERSION" "$VERSIONS_DIR/$VERSION"
  fi

  # Verify extraction — the tarball contains a bundled Bun runtime and adal-cli.js
  if [ ! -f "$VERSIONS_DIR/$VERSION/adal-cli.js" ]; then
    echo -e "${RED}Error: Extraction failed — adal-cli.js not found${NC}" >&2
    exit 1
  fi
}

# ┌─ Main install logic ─────────────────────────────────────────────────────────────

install_version() {
  printf "\n${MUTED}🌸 Installing ${NC}${APP} ${MUTED}v${VERSION}${NC}"

  local archive_ext="tar.gz"
  if [ "$os" = "win32" ]; then
    archive_ext="zip"
  fi

  local filename="adal-${VERSION}-${PLATFORM}.${archive_ext}"
  local download_url="$RELEASES_URL/${VERSION}/${filename}"

  # Download manifest for checksum
  local manifest_url="$RELEASES_URL/manifests/manifest-${VERSION}.json"
  local manifest_json
  manifest_json=$(download_file "$manifest_url" 2>/dev/null || echo "")

  # Download tarball
  local tmp_dir
  tmp_dir=$(mktemp -d)
  # Clean up the temp dir even on error/signal/interrupt.
  trap 'rm -rf "$tmp_dir"' EXIT
  local archive_path="$tmp_dir/$filename"

  # Download with single-line progress percentage
  if ! download_with_progress "$download_url" "$archive_path" ""; then
    echo -e "${RED}Download failed${NC}" >&2
    exit 1
  fi

  # Schema-validate the manifest and extract checksum + size. The manifest was
  # confirmed to exist during resolve_version(), so a failure here is a hard
  # error — refuse to install unverified artifacts.
  local expected_checksum=""
  local expected_size=""
  if [ -z "$manifest_json" ]; then
    echo -e "${RED}Error: Manifest not found: $manifest_url${NC}" >&2
    echo -e "${MUTED}Refusing to install without integrity verification.${NC}" >&2
    exit 1
  fi
  local parsed
  parsed=$(parse_manifest "$manifest_json" "$VERSION" "$PLATFORM" "$filename") || {
    echo -e "${MUTED}Refusing to install an unverified artifact.${NC}" >&2
    exit 1
  }
  expected_checksum=$(echo "$parsed" | sed -n '1p')
  expected_size=$(echo "$parsed" | sed -n '2p')

  # Verify size before checksum — cheap first-line integrity check
  if [ -n "$expected_size" ] && [ "$expected_size" -gt 0 ] 2>/dev/null; then
    local actual_size
    if [[ "$(uname -s)" == "Darwin" ]]; then
      actual_size=$(stat -f%z "$archive_path")
    else
      actual_size=$(stat -c%s "$archive_path")
    fi
    if [ "$actual_size" != "$expected_size" ]; then
      echo -e "${RED}Error: Downloaded size $actual_size does not match manifest size $expected_size${NC}" >&2
      exit 1
    fi
  fi

  # Verify checksum
  if ! verify_checksum "$archive_path" "$expected_checksum"; then
    exit 1
  fi

  # Verify Ed25519 signature (enforced when a .minisig file is published)
  local sig_url="$download_url.minisig"
  if ! download_file "$sig_url" "$archive_path.minisig" 2>/dev/null; then
    : # no signature published yet — verify_signature handles the warning
  fi
  if ! verify_signature "$archive_path" "$archive_path.minisig" "$SIGNING_PUBLIC_KEY"; then
    exit 1
  fi

  # Extract
  mkdir -p "$VERSIONS_DIR"

  if [ "$os" = "linux" ]; then
    tar -xzf "$archive_path" -C "$VERSIONS_DIR"
  else
    # macOS and Windows (Git Bash)
    if command -v tar >/dev/null 2>&1 && [ "$archive_ext" = "tar.gz" ]; then
      tar -xzf "$archive_path" -C "$VERSIONS_DIR"
    elif command -v unzip >/dev/null 2>&1; then
      unzip -q "$archive_path" -d "$VERSIONS_DIR"
    else
      echo -e "${RED}Error: No extraction tool available (need tar or unzip)${NC}" >&2
      exit 1
    fi
  fi

  # The tarball extracts to adal-<version>/ — rename to just <version>/
  if [ -d "$VERSIONS_DIR/adal-$VERSION" ]; then
    # Remove existing version dir if somehow there
    rm -rf "${VERSIONS_DIR:?}/$VERSION"
    mv "$VERSIONS_DIR/adal-$VERSION" "$VERSIONS_DIR/$VERSION"
  fi

  # Verify extraction — check the real entry point for this platform
  if [ "$os" = "win32" ]; then
    if [ ! -f "$VERSIONS_DIR/$VERSION/adal.cmd" ]; then
      echo -e "${RED}Error: Extraction failed — adal.cmd not found${NC}" >&2
      exit 1
    fi
  else
    if [ ! -x "$VERSIONS_DIR/$VERSION/adal" ]; then
      echo -e "${RED}Error: Extraction failed — adal not found or not executable${NC}" >&2
      exit 1
    fi
  fi

  # Cleanup
  rm -rf "$tmp_dir"
  trap - EXIT

  # Track after successful extraction — guarantees the row represents a real,
  # finished install/upgrade, not a failed/aborted attempt.
  track_install
}

# ┌─ Symlink setup ────────────────────────────────────────────────────────────────

setup_symlinks() {
  mkdir -p "$BIN_DIR"

  # Update 'current' symlink
  local current_link="$VERSIONS_DIR/current"
  rm -f "$current_link"
  ln -s "$VERSION" "$current_link"

  # Create bin/adal → ../versions/current/adal
  local bin_target="$BIN_DIR/adal"
  rm -f "$bin_target"

  if [ "$os" = "win32" ]; then
    # On Windows/Git Bash, create a shell wrapper instead of symlink
    cat > "$bin_target" << 'WINWRAP'
#!/usr/bin/env sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$SCRIPT_DIR/../versions/current/adal.cmd" "$@"
WINWRAP
    chmod +x "$bin_target"
  else
    ln -s "../versions/current/adal" "$bin_target"
  fi

  setup_immediate_path_shim

  # Symlinks created silently
}

path_contains_dir() {
  local dir="$1"
  [[ ":$PATH:" == *":$dir:"* ]]
}

create_adal_shim() {
  local target_dir="$1"
  local shim_path="$target_dir/adal"
  local expected_target="$VERSIONS_DIR/current/adal"

  [ -d "$target_dir" ] || return 1
  [ -w "$target_dir" ] || return 1

  if [ -L "$shim_path" ] && [ "$(readlink "$shim_path" 2>/dev/null || true)" = "$expected_target" ]; then
    return 2  # Already correct; no user-visible work happened.
  fi

  # Avoid clobbering unrelated real files. Symlinks are safe to refresh because
  # previous npm/native installs commonly expose commands as symlinks.
  if [ -e "$shim_path" ] && [ ! -L "$shim_path" ]; then
    return 1
  fi

  rm -f "$shim_path"
  ln -s "$expected_target" "$shim_path"
  return 0
}

setup_immediate_path_shim() {
  [ "$os" != "win32" ] || return 0

  # Best-effort same-terminal support for `curl | bash` followed by `adal`.
  # The installer cannot change the parent shell's PATH, so only use selected
  # directories that are already in PATH and writable without sudo.
  local candidates=(
    "$HOME/.local/bin"
    "/opt/homebrew/bin"
    "/usr/local/bin"
  )

  local dir
  for dir in "${candidates[@]}"; do
    if path_contains_dir "$dir"; then
      if create_adal_shim "$dir"; then
        echo -e "  ${GREEN}✅ Made adal available in current PATH via $dir${NC}"
        return 0
      elif [ "$?" -eq 2 ]; then
        return 0
      fi
    fi
  done

  # Still create the user-local shim for future shells that include ~/.local/bin.
  mkdir -p "$HOME/.local/bin"
  create_adal_shim "$HOME/.local/bin" || true
}

# ┌─ Clean old versions ────────────────────────────────────────────────────────────

cleanup_old_versions() {
  local versions=()

  # List version directories (exclude 'current' symlink and the just-installed version)
  for dir in "$VERSIONS_DIR"/*/; do
    [ -d "$dir" ] || continue
    local name
    name=$(basename "$dir")
    [ "$name" = "current" ] && continue
    [ "$name" = "$VERSION" ] && continue
    versions+=("$name")
  done

  # Remove all old versions (the current $VERSION is already excluded above)
  if [ ${#versions[@]} -gt 0 ]; then
    for ver in "${versions[@]}"; do
      rm -rf "${VERSIONS_DIR:?}/$ver"
    done
  fi
}

# ┌─ PATH setup ────────────────────────────────────────────────────────────────

add_to_path() {
  local config_file="$1"
  local command="$2"
  local legacy_command="${command//\$HOME/$HOME}"

  if grep -Fxq "$command" "$config_file" 2>/dev/null || \
     grep -Fxq "$legacy_command" "$config_file" 2>/dev/null; then
    return 0  # Already present
  fi

  if [ -w "$config_file" ]; then
    echo "" >> "$config_file"
    echo "$command" >> "$config_file"
    echo -e "  ${GREEN}✅ Added AdaL to PATH in $config_file${NC}"
  else
    echo -e "  ${YELLOW}Manually add to $config_file:${NC}"
    echo -e "    $command"
  fi
}

setup_path() {
  if [ "$no_modify_path" = true ]; then
    return 0
  fi

  # Check if already in PATH
  if [[ ":$PATH:" == *":$BIN_DIR:"* ]]; then
    return 0
  fi

  local current_shell
  current_shell=$(basename "${SHELL:-/bin/sh}")

  local config_files=""
  local default_config_file=""
  case "$current_shell" in
    fish)
      config_files="$HOME/.config/fish/config.fish"
      default_config_file="$HOME/.config/fish/config.fish"
      ;;
    zsh)
      config_files="${ZDOTDIR:-$HOME}/.zshrc"
      default_config_file="${ZDOTDIR:-$HOME}/.zshrc"
      ;;
    bash)
      config_files="$HOME/.bashrc $HOME/.bash_profile $HOME/.profile"
      default_config_file="$HOME/.bashrc"
      ;;
    ash|sh)
      config_files="$HOME/.profile"
      default_config_file="$HOME/.profile"
      ;;
    *)
      config_files="$HOME/.bashrc $HOME/.bash_profile $HOME/.profile"
      default_config_file="$HOME/.profile"
      ;;
  esac

  # Find the first existing config file.
  local config_file=""
  for file in $config_files; do
    if [ -f "$file" ]; then
      config_file="$file"
      break
    fi
  done

  # Fresh machines may not have a shell config yet. Create the default one so
  # future terminals can find AdaL without requiring manual PATH setup.
  if [ -z "$config_file" ]; then
    config_file="$default_config_file"
    mkdir -p "$(dirname "$config_file")"
    touch "$config_file"
  fi

  case "$current_shell" in
    fish) add_to_path "$config_file" "fish_add_path \$HOME/.adal/bin" ;;
    *)    add_to_path "$config_file" "export PATH=\"\$HOME/.adal/bin:\$PATH\"" ;;
  esac
}

setup_github_actions_path() {
  if [ -n "${GITHUB_ACTIONS:-}" ] && [ "${GITHUB_ACTIONS}" = "true" ] && [ -n "${GITHUB_PATH:-}" ]; then
    if ! grep -qx "$BIN_DIR" "$GITHUB_PATH" 2>/dev/null; then
      echo "$BIN_DIR" >> "$GITHUB_PATH"
      echo -e "  ${GREEN}✅ Added to \$GITHUB_PATH${NC}"
    fi
  fi
}

# ┌─ Migration detection ────────────────────────────────────────────────────────────

detect_npm_install() {
  if command -v adal >/dev/null 2>&1; then
    local existing_path
    existing_path=$(which adal 2>/dev/null || command -v adal 2>/dev/null || true)
    if [ -n "$existing_path" ] && [[ "$existing_path" != *".adal/bin"* ]]; then
      # Silently note the npm install exists — don't suggest uninstalling
      # because that can break 'adal' command if ~/.adal/bin isn't in PATH yet.
      # Both coexist safely; native takes priority after terminal restart.
      :
    fi
  fi
}

print_success() {
  echo -e ""
  echo -e "${GREEN}🌸 AdaL CLI v${VERSION} installed!${NC}"
  echo -e ""
  echo -e "${MUTED}Location: ${NC}$BIN_DIR/adal"
  echo -e ""
  echo -e "${MUTED}Next: Run ${NC}adal${MUTED} in your working directory${NC}"
  echo -e ""
}

# ┌─ Anonymous install tracking (OPT-IN) ────────────────────────────────────────────

# Fire-and-forget POST so we can count actual installs/upgrades.
# Only called from install_version(), so same-version no-op reinstalls don't
# fire (check_existing() exits earlier on that path).
#
# Default is OFF. Enabled by --track or ADAL_TRACK=1. Always overridable with
# --no-track / ADAL_NO_TRACK=1.
#
# The payload is HMAC-SHA256 signed (X-Adal-Signature) with a timestamp and
# nonce so the server can reject stale/replayed/naively-forged requests. The
# secret is embedded in this public script — this is obfuscation, not auth;
# the server must additionally rate-limit by IP/UA. See RELEASE.md.
track_install() {
  [ "$no_track" = true ] && return 0
  if [ "${ADAL_TRACK:-0}" != "1" ] && [ "$track_opt_in" != true ]; then
    return 0
  fi
  [ "${ADAL_NO_TRACK:-0}" = "1" ] && return 0
  [ -z "$TRACK_URL" ] && return 0

  # Two channels: "stable" = clean semver (X.Y.Z exactly), "beta" = anything else.
  local channel="stable"
  case "$VERSION" in
    *-*) channel="beta" ;;
  esac

  # install vs upgrade — does any prior version dir exist?
  local event_type="install"
  if [ -d "$VERSIONS_DIR" ]; then
    for dir in "$VERSIONS_DIR"/*/; do
      [ -d "$dir" ] || continue
      local name
      name=$(basename "$dir")
      [ "$name" = "current" ] && continue
      [ "$name" = "$VERSION" ] && continue
      event_type="upgrade"
      break
    done
  fi

  local ts nonce
  ts=$(date +%s 2>/dev/null || echo 0)
  nonce=$( (head -c 16 /dev/urandom 2>/dev/null || echo "random") | od -An -tx1 2>/dev/null | tr -d ' \n' | head -c 32)

  local body="{\"platform\":\"cli\",\"channel\":\"$channel\",\"event_type\":\"$event_type\",\"version\":\"$VERSION\",\"ts\":\"$ts\",\"nonce\":\"$nonce\"}"

  local sig=""
  if command -v openssl >/dev/null 2>&1; then
    sig=$(printf '%s' "$body" | openssl dgst -sha256 -hmac "$TRACK_HMAC_SECRET" 2>/dev/null | awk '{print $NF}')
  elif command -v python3 >/dev/null 2>&1; then
    sig=$(printf '%s' "$body" | python3 -c 'import sys,hmac,hashlib; print(hmac.new(sys.argv[1].encode(), sys.stdin.buffer.read(), hashlib.sha256).hexdigest())' "$TRACK_HMAC_SECRET" 2>/dev/null)
  fi

  (
    if [ "$DOWNLOADER" = "curl" ]; then
      curl -fsS -m 2 -X POST -H 'content-type: application/json' \
        -H "X-Adal-Signature: $sig" -H "X-Adal-Ts: $ts" -H "X-Adal-Nonce: $nonce" \
        -d "$body" "$TRACK_URL" >/dev/null 2>&1 || true
    elif [ "$DOWNLOADER" = "wget" ]; then
      wget -q -T 2 --header='content-type: application/json' \
        --header="X-Adal-Signature: $sig" --header="X-Adal-Ts: $ts" --header="X-Adal-Nonce: $nonce" \
        --post-data="$body" -O /dev/null "$TRACK_URL" >/dev/null 2>&1 || true
    fi
  ) &
  disown 2>/dev/null || true
}

# ┌─ Main ───────────────────────────────────────────────────────────────────────────

main() {
  detect_platform
  ensure_musl_runtime_deps

  if [ -n "$local_tarball" ]; then
    # Local tarball mode: skip download, version resolution, and checksum
    install_from_local_tarball "$local_tarball"
  else
    detect_downloader
    resolve_version
    check_existing
    install_version
  fi

  setup_symlinks
  cleanup_old_versions
  setup_path
  setup_github_actions_path
  detect_npm_install
  print_success
}

main