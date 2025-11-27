#!/bin/bash
# Universal media organiser — sorts images and videos by capture/creation date

SRC="/mnt/veracrypt/syncthing/phone/photos/inbox"
DEST="/mnt/veracrypt/syncthing/phone/photos/archive"
LOG="/var/log/sort_photos_by_date.log"

mkdir -p "$DEST"
echo "==== $(date '+%F %T') Starting media sort ====" >> "$LOG"

# --- Sort images by EXIF CreateDate ---
/usr/bin/exiftool -q -m -r -if '$CreateDate' \
  '-Directory<CreateDate' -d "$DEST/%Y/%m" \
  "$SRC" -ext jpg -ext jpeg -ext png -ext heic \
  >> "$LOG" 2>&1

# --- Sort videos using mediainfo ---
find "$SRC" -type f \( -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" -o -iname "*.mkv" -o -iname "*.3gp" \) | while read -r FILE; do
  # Try to read creation date from mediainfo
  DATE=$(/usr/bin/mediainfo --Output="General;%Recorded_Date%" "$FILE" 2>/dev/null | sed 's/.*UTC //;s/[: ]/-/g' | cut -d- -f1-3)
  [ -z "$DATE" ] && DATE=$(date -r "$FILE" +%Y-%m-%d)
  YEAR=${DATE:0:4}
  MONTH=${DATE:5:2}
  TARGET="$DEST/$YEAR/$MONTH"
  mkdir -p "$TARGET"
  mv -n "$FILE" "$TARGET/" && echo "Moved video: $FILE → $TARGET/" >> "$LOG"
done

# --- Deduplicate identical files (keep one copy) ---
/usr/bin/fdupes -rdN "$DEST" >> "$LOG" 2>&1

echo "==== $(date '+%F %T') Completed media sort ====" >> "$LOG"

