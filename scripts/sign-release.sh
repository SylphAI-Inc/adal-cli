#!/usr/bin/env bash
set -euo pipefail

# AdaL release signing script (minisign / Ed25519)
#
# Signs every release tarball and writes a detached <tarball>.minisig next to
# it. The installer (install.sh) downloads <tarball>.minisig and verifies it
# against the embedded public key.
#
# Usage:
#   scripts/sign-release.sh \
#     --version 1.5.7 \
#     --key     /path/to/adal-release.minisign \
#     --files   dist/adal-1.5.7-*.tar.gz dist/adal-1.5.7-*.zip
#
# Env:
#   ADAL_SIGNING_KEY   alternative to --key
#
# The private key must NEVER be committed to a repo or embedded in the
# installer. Store it in CI secrets / a secrets manager; the PUBLIC key lives
# in install.sh as SIGNING_PUBLIC_KEY.

usage() {
  cat <<EOF
Usage: sign-release.sh --version <VER> --key <PRIVATE_KEY> --files <GLOB...>

Options:
  --version <VER>    Release version (e.g. 1.5.7) — used only for output naming
  --key <PATH>       Path to the minisign secret key (adal-release.minisign)
  --files <GLOB...>  One or more globs matching the tarballs/zips to sign
  --check            Only verify existing .minisig files against the public key
  -h, --help         Show this help
EOF
}

check=false
version=""
key_path="${ADAL_SIGNING_KEY:-}"
files=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage; exit 0 ;;
    --check) check=true; shift ;;
    --version) version="$2"; shift 2 ;;
    --key) key_path="$2"; shift 2 ;;
    --files) shift; files+=("$@"); break ;;
    *) echo -e "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

command -v minisign >/dev/null 2>&1 || { echo "minisign is required (brew install minisign / apt install minisign)" >&2; exit 1; }

# Public key must match the one embedded in install.sh
SIGNING_PUBLIC_KEY="RWSZUbVM/EZtFEz8cAk+0zEnPI2cCSQFuSuK4xp0KUlP+Wdf71tvUl7C"

# Expand globs
targets=()
for g in "${files[@]}"; do
  for f in $g; do
    [ -f "$f" ] && targets+=("$f")
  done
done
[ ${#targets[@]} -gt 0 ] || { echo "No files matched the given globs" >&2; exit 1; }

if [ "$check" = true ]; then
  for f in "${targets[@]}"; do
    echo "verify: $f"
    minisign -Vm "$f" -P "$SIGNING_PUBLIC_KEY" -x "$f.minisig" || exit 1
  done
  echo "All signatures OK"
  exit 0
fi

[ -n "$version" ] || { echo "--version is required" >&2; exit 1; }
[ -n "$key_path" ] && [ -f "$key_path" ] || { echo "--key must point to an existing minisign secret key" >&2; exit 1; }

for f in "${targets[@]}"; do
  echo "sign:   $f"
  minisign -S -s "$key_path" -m "$f" -x "$f.minisig"
done

echo ""
echo "Done. Upload each <tarball>.minisig next to its tarball in S3:"
echo "  s3://.../cli/<version>/adal-<version>-<platform>.tar.gz.minisig"
echo ""
echo "Public key (must match install.sh SIGNING_PUBLIC_KEY):"
echo "  $SIGNING_PUBLIC_KEY"