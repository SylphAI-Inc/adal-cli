#!/usr/bin/env bash
# Shared helpers for the installer test suite.
# Zero dependencies: plain bash, runs on macOS + Linux.

PASS=0
FAIL=0
CURRENT_TEST=""

t() { CURRENT_TEST="$1"; }

ok() { PASS=$((PASS + 1)); echo "  ok  $CURRENT_TEST"; }

fail() {
  FAIL=$((FAIL + 1))
  echo "  FAIL $CURRENT_TEST — $1" >&2
  [ -n "${2:-}" ] && echo "       $2" >&2
}

assert_eq() { [ "$1" = "$2" ] && ok || fail "expected '$2', got '$1'"; }
assert_contains() {
  case "$1" in
    *"$2"*) ok ;;
    *) fail "output should contain '$2'" ; echo "$1" | sed 's/^/       | /' >&2 ;;
  esac
}
assert_not_contains() {
  case "$1" in
    *"$2"*) fail "output should NOT contain '$2'" ; echo "$1" | sed 's/^/       | /' >&2 ;;
    *) ok ;;
  esac
}
assert_zero() { { [ -n "$1" ] && [ "$1" -eq 0 ]; } && ok || fail "expected exit 0, got '${1:-}'"; }
assert_nonzero() { { [ -n "$1" ] && [ "$1" -ne 0 ]; } && ok || fail "expected non-zero exit, got '${1:-}'"; }
assert_file() { [ -f "$1" ] && ok || fail "expected file $1 to exist"; }
assert_exec() { [ -x "$1" ] && ok || fail "expected $1 to be executable"; }

# Extract function bodies from install.sh (BSD-awk safe)
extract_funcs() {
  local src="$1"; shift
  for fn in "$@"; do
    awk -v fn="$fn" '
      index($0, fn "()") > 0 && $0 ~ /\)[[:space:]]*\{/ { in_fn = 1 }
      in_fn { print }
      in_fn && $0 == "}" { in_fn = 0; print "" }
    ' "$src"
  done
}

# Exit non-zero if any test failed
finish() {
  echo ""
  echo "  Results: $PASS passed, $FAIL failed"
  [ "$FAIL" -eq 0 ] || exit 1
  exit 0
}
