# Useful Forensics Commands

## File Analysis
```bash
file suspicious_file          # identify file type
xxd suspicious_file | head    # hex dump
strings suspicious_file       # extract strings
exiftool document.pdf         # metadata extraction
binwalk firmware.bin          # embedded file detection
```

## Deleted File Recovery
```bash
foremost -t all -i evidence.dd -o recovered/
scalpel evidence.dd -o recovered/
photorec evidence.dd          # GUI-based recovery
```

## Timeline Analysis
```bash
# Create filesystem timeline
fls -r -m "/" evidence.dd > body_file.txt
mactime -b body_file.txt -d > timeline.csv

# Filter by date
grep "2024-03-15" timeline.csv
```

## Log Analysis
```bash
# Failed SSH logins
grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -rn

# Web server 404s
awk '$9 == 404' /var/log/nginx/access.log | awk '{print $7}' | sort | uniq -c | sort -rn

# Last logins
last -n 20
lastlog
```

## Hash Verification
```bash
md5sum file.iso
sha256sum file.iso
sha256sum -c checksums.txt    # verify against list
```
