#!/usr/bin/env bash

pushd () {
  command pushd "$@" > /dev/null
}

popd () {
  command popd "$@" > /dev/null
}

go() {
  local ERROR=0;
  for file in $(find -type f -name "*.dhall"); do
    pushd $(dirname $file);
    cat $(basename $file) | dhall --explain resolve > /dev/null;
    if [ "$?" -ne "0" ]; then
      echo "Failed to resolve $file"
      ERROR=1;
    fi;
    popd;
  done;
  exit $ERROR;
}

go
