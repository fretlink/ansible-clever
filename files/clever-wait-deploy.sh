#!/bin/bash -e

function deploying {
  checkStatus "$1" "IN PROGRESS"
}

function deployed {
  checkStatus "$1" "OK"
}

function inactive {
  local commit="$1"
  [[ "$(clever activity | grep "$commit" | grep "DEPLOY" | wc -l)" == "0" ]]
}

function checkStatus {
  local commit="$1"
  local status="$2"
  [[ "$(clever activity | grep "$commit" | grep "${status}\s\+DEPLOY" | wc -l)" == "1" ]]
}

function check {
  local timeout=600 # 10 minutes
  local commit="$1"
  local samplingTime=5

  echo "Waiting for deployment start..."
  while inactive "$commit" -a $timeout -gt 0
  do
    sleep $samplingTime
    let "timeout-=$samplingTime"
  done

  # Wait for completion
  echo "Deployment in progress..."
  while deploying "$commit" -a $timeout -gt 0
  do
    sleep $samplingTime
    let "timeout-=$samplingTime"
  done

  if [ $samplingTime -eq 0 ]
  then
    echo "Timeout"
  fi

  deployed "$commit"
}

function getHeadRev {
  git rev-parse HEAD
}

check "$(getHeadRev)"
