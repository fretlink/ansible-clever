#!/usr/bin/env bash

set -eo pipefail

go() {
  local ERROR=0
  while IFS= read -r -d '' file
  do
    cd "$(dirname "$file")" || exit
    echo "Typechecking ${file}"
    if ! dhall --explain resolve < "$(basename "$file")" >/dev/null; then
      echo "Failed to resolve $file"
      ERROR=1
    fi;
    cd - >/dev/null || exit
  done <   <(find . -type f -name "*.dhall" -print0)
  exit $ERROR;
}

go
