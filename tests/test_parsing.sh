#!/usr/bin/env bash
# Unit tests for the parsing/validation helpers in install.sh
set -u
SRC="${SRC:-$(cd "$(dirname "$0")/.." && pwd)/install.sh}"

# shellcheck disable=SC1091
source "$(dirname "$0")/lib.sh"

eval "$(extract_funcs "$SRC" json_get json_get_num json_get_platform validate_version)"

echo "== json_get / json_get_num / json_get_platform =="

t "json_get string value"
assert_eq "$(json_get '{"a":"b"}' "a")" "b"

t "json_get missing key is empty"
assert_eq "$(json_get '{"a":"b"}' "nope")" ""

t "json_get_num numeric value"
assert_eq "$(json_get_num '{"n":42}' "n")" "42"

t "json_get_platform nested under platforms key (real manifest shape)"
assert_contains "$(json_get_platform '{"version":"1.2.3","platforms":{"darwin-arm64":{"checksum":"abc","size":1}}}' "darwin-arm64")" '"checksum":"abc"'

t "json_get_platform top-level placement"
assert_contains "$(json_get_platform '{"linux-x64":{"checksum":"xyz","size":2}}' "linux-x64")" '"checksum":"xyz"'

t "json_get_platform missing platform is empty"
assert_eq "$(json_get_platform '{"version":"1"}' "win32-x64")" ""

t "json_get_platform ignores nested false-positive keys"
# A value that merely CONTAINS the platform name must not be extracted as a block
assert_eq "$(json_get_platform '{"note":"darwin-arm64 is neat"}' "darwin-arm64")" ""

echo ""
echo "== validate_version =="

t "accepts plain semver"
validate_version "1.2.3" && ok || fail "1.2.3 should pass"

t "accepts beta suffix"
validate_version "1.2.3-beta.1" && ok || fail "1.2.3-beta.1 should pass"

t "accepts rc suffix"
validate_version "1.2.3-rc.2" && ok || fail "1.2.3-rc.2 should pass"

t "rejects path traversal"
(validate_version "1.2.3/../../etc" 2>/dev/null) && fail "traversal accepted" || ok

t "rejects double dot in suffix"
(validate_version "1.2.3-beta..1" 2>/dev/null) && fail "double-dot accepted" || ok

t "rejects incomplete version"
(validate_version "1.2" 2>/dev/null) && fail "1.2 accepted" || ok

t "rejects v prefix"
(validate_version "v1.2.3" 2>/dev/null) && fail "v-prefix accepted" || ok

t "rejects empty version"
(validate_version "" 2>/dev/null) && fail "empty accepted" || ok

echo ""
echo "== tarball filename validation =="

validate_tarball_name() {
  [[ "$1" =~ ^adal-[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*)?-(darwin|linux|win32)-(x64|arm64)(-musl)?\.(tar\.gz|zip)$ ]]
}

t "accepts darwin arm64 tarball"
validate_tarball_name "adal-1.5.7-darwin-arm64.tar.gz" && ok || fail "should accept"

t "accepts musl tarball"
validate_tarball_name "adal-0.6.0-beta.1-linux-x64-musl.tar.gz" && ok || fail "should accept"

t "accepts win32 zip"
validate_tarball_name "adal-1.2.3-win32-x64.zip" && ok || fail "should accept"

t "rejects command substitution in filename"
validate_tarball_name 'adal-1.0.0-$(reboot)-linux-x64.tar.gz' && fail "injection accepted" || ok

t "rejects path traversal in filename"
validate_tarball_name 'adal-1.2.3-../../etc-linux-x64.tar.gz' && fail "traversal accepted" || ok

t "rejects unsupported platform segment"
validate_tarball_name "adal-1.2.3-FREEBSD-x64.tar.gz" && fail "unsupported OS accepted" || ok

t "rejects missing version"
validate_tarball_name "adal--linux-x64.tar.gz" && fail "missing version accepted" || ok

finish