#!/usr/bin/env bash

binary="${0/*\/}"
localCommit="${PRETEND_LOCAL_COMMIT:-aaa000aaa000aaa000aaa000aaa000aaa000aaa0}"
remoteCommit="${PRETEND_REMOTE_COMMIT:-bbb000bbb000bbb000bbb000bbb000bbb000bbb0}"
uptodateDeployment="${DEPLOY_UP_TO_DATE_APP:-}"

echo "${1}" >> "${binary}-commands"

if [ "${binary}" = "clever" ] && [ "${1}" = "--version" ]; then
    echo "2.6.1"
elif [ "${binary}" = "clever" ] && [ "${1}" = "activity" ]; then
    echo "2020-02-02T20:20:02+02:00  OK         DEPLOY     ${remoteCommit}  Git"
elif [ "${binary}" = "clever" ] && [ "${1}" = "status" ]; then
    echo "test-app: running (1*pico,  Commit: ${remoteCommit})"
elif [ "${binary}" = "clever" ] && [ "${1}" = "deploy" ]; then
    if [ -z "${uptodateDeployment}" ]; then
        echo "Clever deploy done."
    else
        # Mimic the current behavior until https://github.com/CleverCloud/clever-tools/issues/422 is solved
        >&2 echo "The clever-cloud application is up-to-date. Try this command to restart the application:"
        >&2 echo "        clever restart"
        exit 1
    fi
elif [ "${binary}" = "git" ]; then
    echo "${localCommit}"
else
    echo "${binary} called with arguments: ${*}"
fi
