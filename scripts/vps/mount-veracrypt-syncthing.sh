#!/bin/bash
set -e

MOUNTPOINT="/mnt/veracrypt/syncthing"
CONTAINER="/srv/secure/syncCont.vc"

if mount | grep -q "$MOUNTPOINT"; then
    echo "Already mounted."
    exit 0
fi

# Ask systemd to prompt for password securely
PASSWORD=$(systemd-ask-password "Enter VeraCrypt password for $CONTAINER")

echo "Mounting VeraCrypt container..."
veracrypt --text --non-interactive --password="$PASSWORD" \
	--pim=0 \
	--protect-hidden=no \
	--mount "$CONTAINER" "$MOUNTPOINT"

chown -R dp:dp "$MOUNTPOINT"

