#!/usr/bin/env bash

set -eo pipefail
params=()
if [ -n "$INSTANCES" ]; then
  params+=("--instances" "${INSTANCES}")
elif [ -n "$MIN_INSTANCES" ] && [ -n "$MAX_INSTANCES" ]; then
  params+=("--min-instances" "${MIN_INSTANCES}")
  params+=("--max-instances" "${MAX_INSTANCES}")

fi
if [ -n "$FLAVOR" ]; then
  params+=("--flavor" "${FLAVOR}")
elif [ -n "$MIN_FLAVOR" ] && [ -n "$MAX_FLAVOR" ]; then
  params+=("--min-flavor" "${MIN_FLAVOR}")
  params+=("--max-flavor" "${MAX_FLAVOR}")
fi

clever scale "${params[@]}"
