#!/bin/bash
# Ping the VPS to make sure it's reachable
if ping -c1 -W2 100.65.0.9 >/dev/null 2>&1; then
    echo "$(date) Starting remote Restic backup..."
    ssh dp@100.65.0.9 "sudo /usr/local/bin/restic-system-backup.sh"
else
    echo "$(date) VPS not reachable, skipping."
fi

