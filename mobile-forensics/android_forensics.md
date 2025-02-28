# Android Forensics Notes

## Evidence Sources

### Physical acquisition (root/bootloader unlock required)
```bash
adb shell dd if=/dev/block/mmcblk0 | dd of=full_image.dd
```

### Logical acquisition
```bash
adb backup -apk -shared -all -f backup.ab
# Convert to tar:
dd if=backup.ab bs=24 skip=1 | python3 -c "import zlib,sys; sys.stdout.buffer.write(zlib.decompress(sys.stdin.buffer.read()))" > backup.tar
```

## Key Artifact Locations
- `/data/data/<package>/databases/` — SQLite databases
- `/data/data/com.android.providers.contacts/` — Contacts
- `/data/data/com.android.providers.telephony/` — SMS/MMS
- `/data/data/com.whatsapp/databases/` — WhatsApp messages
- `/sdcard/DCIM/` — Photos and videos
- `/data/system/packages.xml` — Installed apps list

## SQLite Analysis
```bash
sqlite3 mmssms.db ".tables"
sqlite3 mmssms.db "SELECT address, date, body FROM sms ORDER BY date DESC LIMIT 20;"
```

## Timestamps
Android uses Unix epoch in milliseconds:
```bash
date -d @$(echo "1700000000000/1000" | bc)
```
