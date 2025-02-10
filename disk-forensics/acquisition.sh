#!/bin/bash
# Forensic Disk Acquisition Script
# Always acquire evidence BEFORE analysis — preserve original

EVIDENCE_DRIVE="/dev/sdb"    # <-- CHANGE: target drive
OUTPUT_DIR="/mnt/evidence"
CASE_ID="CASE_$(date +%Y%m%d_%H%M%S)"

mkdir -p "$OUTPUT_DIR/$CASE_ID"

echo "[*] Starting forensic acquisition: $CASE_ID"
echo "[*] Source: $EVIDENCE_DRIVE"
echo "[*] Destination: $OUTPUT_DIR/$CASE_ID"
echo ""

# Pre-acquisition hash
echo "[1] Computing pre-acquisition hash..."
sha256sum "$EVIDENCE_DRIVE" > "$OUTPUT_DIR/$CASE_ID/pre_hash.txt"
cat "$OUTPUT_DIR/$CASE_ID/pre_hash.txt"

# Acquire with dd (block-level copy)
echo ""
echo "[2] Acquiring disk image..."
dd if="$EVIDENCE_DRIVE" \
   of="$OUTPUT_DIR/$CASE_ID/evidence.dd" \
   bs=512 \
   conv=noerror,sync \
   status=progress 2>&1 | tee "$OUTPUT_DIR/$CASE_ID/acquisition.log"

# Post-acquisition hash
echo ""
echo "[3] Verifying acquisition integrity..."
sha256sum "$OUTPUT_DIR/$CASE_ID/evidence.dd" > "$OUTPUT_DIR/$CASE_ID/post_hash.txt"
cat "$OUTPUT_DIR/$CASE_ID/post_hash.txt"

echo ""
echo "[*] Acquisition complete: $OUTPUT_DIR/$CASE_ID/evidence.dd"
echo "[*] Chain of custody log: $OUTPUT_DIR/$CASE_ID/acquisition.log"
