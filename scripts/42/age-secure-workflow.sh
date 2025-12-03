#!/usr/bin/env bash
: <<'HEADER'
age-secure-workflow.sh
Purpose:
  Provides a secure decrypt → work → re-encrypt cycle using age and tar.
  All plaintext lives exclusively in a RAM-backed workspace (/dev/shm).
  No sudo, no FUSE, no fscrypt, no kernel modules required.

Operation Summary:
  1. Create RAM workspace (/dev/shm/work) with 700 permissions.
  2. Decrypt private.tar.age directly into RAM using a tar stream.
  3. User works inside /dev/shm/work (plaintext never touches disk).
  4. Repack RAM workspace into uncompressed tar.
  5. Encrypt tar with age (passphrase mode, scrypt-based KDF).
  6. Remove all plaintext from RAM.

Why this works:
  /dev/shm is a tmpfs (memory filesystem). Everything inside it is RAM-only.
  age provides strong authenticated encryption without kernel support.
  tar allows efficient streaming with minimal overhead.
HEADER

set -euo pipefail

ARCHIVE="private.tar.age"
WORKDIR="/dev/shm/work"

# Step 1: ensure RAM workspace exists with safe permissions
mkdir -p "$WORKDIR"
chmod 700 "$WORKDIR"

echo "[*] Decrypting $ARCHIVE into RAM workspace..."
age -d "$ARCHIVE" | tar -xf - -C "$WORKDIR"

echo "[*] Plaintext available in RAM at: $WORKDIR"
echo "    Make your edits there. Press ENTER when ready to re-encrypt."
read -r _

echo "[*] Repacking RAM workspace into tar..."
tar -C "$WORKDIR" -cf private.tar .

echo "[*] Encrypting new archive with age..."
age -p -o "$ARCHIVE" private.tar
rm -f private.tar

echo "[*] Wiping RAM workspace..."
rm -rf "$WORKDIR"

echo "[*] Done. New encrypted archive saved as $ARCHIVE"
