#!/bin/bash

# Arguments:
# 1 - local path to folder to synchronize
# 2 - host in format user@server.domain.com
# 3 - remote path to folder to synchronize

if [[ $# -ne 3 ]]; then
    echo "There must be exactly 3 arguments!"
    exit 1
fi

LOCAL=$1
REMOTE="$2:$3"

echo "Syncing $LOCAL with $REMOTE"

rsync -r -a -v -e ssh $LOCAL $REMOTE
