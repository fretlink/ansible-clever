#!/usr/bin/env bash

function getHeadRev {
  git rev-parse HEAD
}

target_commit="$(getHeadRev)"
running_commit=$(clever status | grep running | sed 's/^.*Commit: //' | sed 's/)$//')

if [ "${running_commit}" != "${target_commit}" ]; then
  echo "Deploying commit ${target_commit}"
  clever deploy --force
else
  echo "${target_commit} is already deployed, nothing to do"
fi
