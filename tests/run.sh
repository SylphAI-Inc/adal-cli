#!/usr/bin/env bash
# Test runner: executes every tests/test_*.sh and aggregates results.
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"

pass=0
fail=0
failed_files=()

for t in "$HERE"/test_*.sh; do
  echo "== $(basename "$t") =="
  if bash "$t"; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    failed_files+=("$(basename "$t")")
  fi
  echo ""
done

echo "======================================"
echo "Suites: $pass passed, $fail failed"
if [ ${#failed_files[@]} -gt 0 ]; then
  printf 'Failed: %s\n' "${failed_files[*]}"
  exit 1
fi
echo "All installer tests passed."
exit 0
