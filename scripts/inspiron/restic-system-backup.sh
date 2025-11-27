#!/bin/bash
# ================================================================
# Trigger VPS restic backup from Inspiron when HDD is mounted
# ================================================================

VPS_IP="100.65.0.9"
LOGFILE="/var/log/restic-udev.log"

# Abort if external HDD is not mounted
if ! mountpoint -q /media/veracrypt1; then
    echo "[$(date '+%F %T')] HDD not mounted, skipping backup." | tee -a "$LOGFILE"
    exit 0
fi

echo "[$(date '+%F %T')] External HDD detected — triggering VPS backup..." | tee -a "$LOGFILE"

if ! ping -c1 -W2 "$VPS_IP" >/dev/null 2>&1; then
    echo "[$(date '+%F %T')] VPS not reachable via Tailscale (ping failed)." | tee -a "$LOGFILE"
    exit 1
fi

ssh -i /home/dp/.ssh/id_ed25519_inspiron \
    -o StrictHostKeyChecking=accept-new \
    -o User=dp \
    100.65.0.9 "sudo /usr/local/bin/restic-system-backup.sh" 2>&1 | tee -a "$LOGFILE"

echo "[$(date '+%F %T')] Trigger script finished." | tee -a "$LOGFILE"
