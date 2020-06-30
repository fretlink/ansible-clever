#!/usr/bin/env bash

binary="${0/*\/}"
localCommit="${PRETEND_LOCAL_COMMIT:-aaa000aaa000aaa000aaa000aaa000aaa000aaa0}"
remoteCommit="${PRETEND_REMOTE_COMMIT:-bbb000bbb000bbb000bbb000bbb000bbb000bbb0}"

if [ "${binary}" = "clever" ] && [ "${1}" = "--version" ]; then
    echo "2.6.1"
elif [ "${binary}" = "clever" ] && [ "${1}" = "activity" ]; then
    echo "2020-02-02T20:20:02+02:00  OK         DEPLOY     ${remoteCommit}  Git"
elif [ "${binary}" = "clever" ] && [ "${1}" = "status" ]; then
    echo "test-app: running (1*pico,  Commit: ${remoteCommit})"
elif [ "${binary}" = "git" ]; then
    echo "${localCommit}"
else
    echo "${1}" >> "${binary}-commands"
    echo "${binary} called with arguments: ${*}"
fi
