#!/bin/bash
# PCAP Analysis Helper
# Usage: ./pcap_analysis.sh capture.pcap

PCAP="$1"
[[ -z "$PCAP" ]] && { echo "Usage: $0 <file.pcap>"; exit 1; }

echo "=== PCAP Analysis: $PCAP ==="
echo ""

echo "--- Basic Statistics ---"
capinfos "$PCAP" 2>/dev/null || tshark -r "$PCAP" -q -z io,stat,0

echo ""
echo "--- Top Talkers (IP) ---"
tshark -r "$PCAP" -q -z conv,ip | head -20

echo ""
echo "--- DNS Queries ---"
tshark -r "$PCAP" -Y "dns.flags.response == 0" -T fields -e dns.qry.name | sort | uniq -c | sort -rn | head -20

echo ""
echo "--- HTTP Requests ---"
tshark -r "$PCAP" -Y http.request -T fields -e http.host -e http.request.uri | head -20

echo ""
echo "--- Suspicious: Long DNS names (possible DGA/tunneling) ---"
tshark -r "$PCAP" -Y "dns" -T fields -e dns.qry.name | awk 'length > 40' | sort -u
