#!/bin/bash
# ================================================================
# veracrypt-unmount.sh — Cleanly unmount VeraCrypt container + HDD
# ================================================================

LOGFILE="/var/log/veracrypt-backup.log"
CONTAINER="/media/dp/Seagate/seaCont.dev"
MAPPER="testmap"
MOUNTPOINT="/media/veracrypt1"
HDDMOUNT="/media/dp/Seagate"

echo "[$(date '+%F %T')] Unmount trigger detected — starting cleanup." | tee -a "$LOGFILE"

# --- Unmount VeraCrypt filesystem ---
if mountpoint -q "$MOUNTPOINT"; then
    echo "[$(date '+%F %T')] Unmounting VeraCrypt filesystem..." | tee -a "$LOGFILE"
    if sudo umount "$MOUNTPOINT"; then
        echo "[$(date '+%F %T')] Filesystem unmounted successfully." | tee -a "$LOGFILE"
    else
        echo "[$(date '+%F %T')] WARNING: Failed to unmount filesystem." | tee -a "$LOGFILE"
    fi
else
    echo "[$(date '+%F %T')] VeraCrypt filesystem already unmounted." | tee -a "$LOGFILE"
fi

# --- Close mapper if it exists ---
if sudo dmsetup status "$MAPPER" &>/dev/null; then
    echo "[$(date '+%F %T')] Closing VeraCrypt mapper..." | tee -a "$LOGFILE"
    if sudo cryptsetup close "$MAPPER"; then
        echo "[$(date '+%F %T')] Mapper closed successfully." | tee -a "$LOGFILE"
    else
        echo "[$(date '+%F %T')] WARNING: Failed to close mapper." | tee -a "$LOGFILE"
    fi
else
    echo "[$(date '+%F %T')] Mapper not found — likely already closed." | tee -a "$LOGFILE"
fi

# --- Unmount external HDD ---
if mountpoint -q "$HDDMOUNT"; then
    echo "[$(date '+%F %T')] Unmounting external HDD..." | tee -a "$LOGFILE"
    if sudo umount "$HDDMOUNT"; then
        echo "[$(date '+%F %T')] HDD unmounted successfully." | tee -a "$LOGFILE"
    else
        echo "[$(date '+%F %T')] WARNING: Failed to unmount external HDD." | tee -a "$LOGFILE"
    fi
else
    echo "[$(date '+%F %T')] HDD already unmounted." | tee -a "$LOGFILE"
fi

notify-send "💽 VeraCrypt" "All volumes safely unmounted."
echo "[$(date '+%F %T')] Cleanup complete — VeraCrypt volume safely closed." | tee -a "$LOGFILE"
