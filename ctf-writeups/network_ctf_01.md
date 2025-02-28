# CTF Writeup — Network Forensics

## Challenge
A PCAP file — find the exfiltrated password.

## Tools Used
- Wireshark
- tshark
- CyberChef

## Solution

### Step 1: Overview
```bash
capinfos capture.pcap
# 4,521 packets, 00:03:42 duration
```

### Step 2: Check DNS for tunneling
```bash
tshark -r capture.pcap -Y "dns" -T fields -e dns.qry.name | \
awk 'length > 50' | head -20
# Long subdomains — possible DNS tunneling
```

### Step 3: Extract DNS data
```bash
tshark -r capture.pcap -Y "dns.flags.response == 0" \
-T fields -e dns.qry.name | \
grep "\.attacker\.com" | \
awk -F'.' '{print $1}' > encoded_data.txt
```

### Step 4: Decode Base64
```bash
cat encoded_data.txt | tr -d '\n' | base64 -d
# password: Sup3rS3cr3tP@ss
```

## Key Takeaways
- DNS tunneling often uses long subdomains
- Base64 in DNS queries is a major red flag
- Filter by query length to find anomalies
