#!/bin/bash

echoerr() { echo "$@" 1>&2; }

repopath="/run/media/elements/backups"

if [[ ! -d $repopath ]]; then
	echoerr "Backup: device not mounted"
	exit 1
fi

export HOME=/home/amleczko
export RESTIC_REPOSITORY=$repopath
export RESTIC_PASSWORD_FILE=$HOME/Documents/keepass/resticpass

# Check if repo exists
restic -r $repopath snapshots 2>/dev/null

# Create if not
if [[ $? -ne 0 ]]; then
	echo "Initializing a new repo in $repopath"
	restic init --repo $repopath
fi

# Check repo health
restic -r $repopath check
if [[ $? -ne 0 ]]; then
	echoerr "Backup: repository not healthy"
	exit 2
fi

# Backup
restic -r $repopath backup --verbose $HOME /etc --exclude $HOME/Videos


