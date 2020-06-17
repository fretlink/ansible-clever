#!/usr/bin/env bash

binary="${0/*\/}"
fakeCommit="aaa000aaa000aaa000aaa000aaa000aaa000aaa0"

if [ "${binary}" = "clever" ] && [ "${1}" = "--version" ]; then
    echo "2.6.1"
elif [ "${binary}" = "clever" ] && [ "${1}" = "activity" ]; then
    echo "2020-02-02T20:20:02+02:00  OK         DEPLOY     ${fakeCommit}  Git"
elif [ "${binary}" = "git" ]; then
    echo "${fakeCommit}"
else
    echo "${binary} called with arguments: ${*}"
fi
