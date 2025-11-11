#!/bin/bash
# ============================================================================================
# Restic system backup script — runs via root's cron or manually
#
# Location (Inspiron/ThinkPad): ~/Documents/dotfiles/scripts/vps/restic-system-backup.sh
# Location (VPS): /mnt/veracrypt/syncthing/dotfiles/scripts/vps/restic-system-backup.sh
# ============================================================================================

LOGFILE="/var/log/restic-backup.log"
DATE=$(date '+%F %T')

# === Load secure configuration ===
SECRETS_FILE="/mnt/veracrypt/syncthing/secrets/restic.env"
if [ ! -f "$SECRETS_FILE" ]; then
    echo "==== $DATE Secrets file not found ($SECRETS_FILE). Is VeraCrypt mounted? ====" | tee -a "$LOGFILE"
    exit 1
fi
# shellcheck disable=SC1090
source "$SECRETS_FILE"

# === Start ===
echo "==== $DATE Starting backup ====" | tee -a "$LOGFILE"

# === Run backup with live progress and logging ===
/usr/bin/restic backup --verbose=1 \
    --files-from /etc/restic/include.txt \
    --exclude-file /etc/restic/exclude.txt 2>&1 | tee -a "$LOGFILE"

# === Retention policy ===
echo "---- $(date '+%F %T') Applying retention policy ----" | tee -a "$LOGFILE"
/usr/bin/restic forget \
    --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune 2>&1 | tee -a "$LOGFILE"

# === Summary ===
if [ "${PIPESTATUS[0]}" -eq 0 ]; then
    echo "==== $(date '+%F %T') Backup completed successfully ====" | tee -a "$LOGFILE"
else
    echo "==== $(date '+%F %T') Backup FAILED! Check log. ====" | tee -a "$LOGFILE"
fi

END_TIME=$(date +%s)
DURATION=$(( (END_TIME - $(date -d "$DATE" +%s)) / 60 ))
echo "==== $(date '+%F %T') Backup duration: ${DURATION} min ====" | tee -a "$LOGFILE"

/usr/bin/restic check --quiet >> "$LOGFILE" 2>&1
