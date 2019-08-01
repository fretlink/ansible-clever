#!/usr/bin/env bash

set -ueo pipefail

VERBOSE=${VERBOSE:-}
lastCleverActivity=""
timeout=2300 # 100 seconds less than the Ansible tasks' timeout
startTime=$(date +%s)

function cleverActivity {
  lastCleverActivity=$(clever activity)
}

function ensure {
  local lastReturnCode="$?"

  VERBOSE=true
  verbose

  if isNotTimeout
  then
    if [ "$lastReturnCode" == "0" ]
    then
      echo "✓ Deployment done."
    else
      echo "✗ Deployment failed!"
    fi
  else
    echo "⁈ Deployment timeout... Please check clever logs"
    exit 1
  fi
}

function isNotTimeout {
  [ $(($(date +%s) - startTime)) -lt $timeout ]
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
  while inactive "$commit" && isNotTimeout
  do
    verbose
    sleep $samplingTime
  done

  # Wait for completion
  echo "▪ Deployment in progress..."
  while deploying "$commit" && isNotTimeout
  do
    verbose
    sleep $samplingTime
  done

  deployed "$commit"
}

function getHeadRev {
  local chdir="$1/.git"

  git --git-dir="$chdir" rev-parse HEAD
}

workdir="$(pwd)"
check "$(getHeadRev "${workdir}")"
