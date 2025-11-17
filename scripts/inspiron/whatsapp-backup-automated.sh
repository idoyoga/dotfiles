#!/bin/bash
# =====================================================================
# whatsapp-backup-automated.sh  (Android 11 compatible)
# Incremental ADB → tmp → Restic + Desktop notifications
# =====================================================================

PHONE_SRC="/sdcard/Android/media/com.whatsapp/WhatsApp"
TMP_DIR="$HOME/Downloads/tmp/WhatsAppBackup"
RESTIC_REPO="/media/veracrypt1/Backup/01_System_Backups/Restic_inspiron"
RESTIC_PASS="/etc/restic/restic-pass.txt"
RESTIC_INCLUDE="/etc/restic/include.txt"
RESTIC_EXCLUDE="/etc/restic/exclude.txt"
LOGFILE="/var/log/whatsapp-restic-backup.log"

notify() {
    # show desktop popup even under sudo
    sudo -u "$SUDO_USER" DISPLAY=:0 \
        DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u "$SUDO_USER")/bus" \
        notify-send -u normal -a "WhatsApp Backup" "$1" "$2" 2>/dev/null || true
    echo "[$(date '+%F %T')] $1 — $2" | tee -a "$LOGFILE"
}

notify "Backup Started 📱" "Preparing WhatsApp sync..."

# --- Step 1: Check phone connection ---
if ! adb get-state | grep -q device; then
    notify "Backup Failed ❌" "No phone detected via ADB."
    exit 1
fi

# --- Step 2: Ensure VeraCrypt drive is mounted ---
if ! mountpoint -q /media/veracrypt1; then
    notify "Backup Failed ❌" "VeraCrypt drive not mounted."
    exit 1
fi

# --- Step 3: Prepare tmp dir ---
mkdir -p "$TMP_DIR"

# --- Step 4: Incremental pull ---
notify "Syncing Data..." "Updating new/changed files from phone..."
START_TIME=$(date +%s)

if adb shell command -v rsync >/dev/null 2>&1; then
    # fast native rsync over ADB shell
    adb shell "rsync -a --delete \"$PHONE_SRC/\" /sdcard/WhatsAppSyncTmp/" 2>>"$LOGFILE"
    adb pull /sdcard/WhatsAppSyncTmp "$TMP_DIR/" 2>>"$LOGFILE"
else
    # fallback: emulate incremental copy
    adb pull "$PHONE_SRC" "$TMP_DIR/" --progress 2>>"$LOGFILE"
fi

# --- Step 5: Copy key file (if rooted) ---
adb shell su -c "cat /data/data/com.whatsapp/files/key > /sdcard/whatsappkey.bin" 2>/dev/null
adb pull /sdcard/whatsappkey.bin "$TMP_DIR/" 2>/dev/null
adb shell rm /sdcard/whatsappkey.bin 2>/dev/null

# --- Step 6: Restic backup ---
notify "Backup Running 🕐" "Creating encrypted Restic snapshot..."
BACKUP_OUTPUT=$(mktemp)

if restic -r "$RESTIC_REPO" \
  --password-file "$RESTIC_PASS" \
  backup "$TMP_DIR" \
  --exclude-file "$RESTIC_EXCLUDE" \
  --verbose=1 2>&1 | tee "$BACKUP_OUTPUT" | tee -a "$LOGFILE"; then
    RESTIC_OK=true
else
    RESTIC_OK=false
fi

# --- Step 7: Parse stats ---
END_TIME=$(date +%s)
DURATION_MIN=$(( (END_TIME - START_TIME) / 60 ))
ADDED_SIZE=$(grep -m1 "Added to the repository" "$BACKUP_OUTPUT" | awk -F':' '{print $2}' | xargs)
SNAPSHOT_ID=$(grep -m1 "^snapshot " "$BACKUP_OUTPUT" | awk '{print $2}')

# --- Step 8: Retention & finish ---
if [ "$RESTIC_OK" = true ]; then
    restic -r "$RESTIC_REPO" \
      --password-file "$RESTIC_PASS" \
      forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune >> "$LOGFILE" 2>&1
    notify "Backup Complete ✅" "Snapshot $SNAPSHOT_ID — ${ADDED_SIZE:-unknown} added in ${DURATION_MIN} min."
else
    notify "Backup Failed ❌" "Restic backup failed. See $LOGFILE."
fi

rm -f "$BACKUP_OUTPUT"

