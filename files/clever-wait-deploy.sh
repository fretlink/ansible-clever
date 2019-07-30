#!/usr/bin/env bash

set -ueo pipefail

VERBOSE=${VERBOSE:-}
lastCleverActivity=""

function cleverActivity {
  lastCleverActivity=$(clever activity)
}

function ensure {
  if [ "$?" == "1" ]
  then
    echo "✗ Deployment failed!"
  fi
  VERBOSE=true
  verbose
}

trap ensure EXIT ERR

function deploying {
  checkStatus "$1" "IN PROGRESS"
}

function deployed {
  checkStatus "$1" "OK"
}

function inactive {
  checkStatus "$1" "" "-v"
}

function checkStatus {
  local commit="$1"
  local status="$2"

  cleverActivity
  echo "${lastCleverActivity}" | tail -n1 | grep ${3:+ "${3}"} -q -E "${status}.*DEPLOY.*${commit}"
}

function verbose {
  if [ -n "${VERBOSE}" ]; then
    echo -e "\\nLast clever activity:"
    echo -e "${lastCleverActivity}\\n"
  fi
}

function check {
  local commit="$1"
  local samplingTime=5

  echo "️▫ Waiting for deployment to start..."
  while inactive "$commit"
  do
    verbose
    sleep $samplingTime
  done

  # Wait for completion
  echo "▪ Deployment in progress..."
  while deploying "$commit"
  do
    verbose
    sleep $samplingTime
  done

  deployed "$commit"
  echo "✓ Deployment done."
}

function getHeadRev {
  local chdir="$1/.git"

  git --git-dir="$chdir" rev-parse HEAD
}

workdir="$(pwd)"
check "$(getHeadRev "${workdir}")"
