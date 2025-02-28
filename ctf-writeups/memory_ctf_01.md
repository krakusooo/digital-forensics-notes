# CTF Writeup — Memory Forensics Challenge

## Challenge
Analyze a Windows memory dump and find the flag hidden in a running process.

## Tools Used
- Volatility3
- strings
- grep

## Solution

### Step 1: Identify OS profile
```bash
vol -f memory.dmp windows.info
# Result: Windows 10 x64 18362
```

### Step 2: List processes
```bash
vol -f memory.dmp windows.pslist
# Suspicious: notepad.exe PID 3412 — running without user interaction
```

### Step 3: Dump process memory
```bash
vol -f memory.dmp windows.memmap --pid 3412 --dump
```

### Step 4: Search for flag
```bash
strings pid.3412.dmp | grep -i "flag{"
# Found: flag{m3m0ry_f0r3ns1cs_ftw}
```

## Key Takeaways
- Always check for processes running without a parent explorer.exe
- Notepad can be used to hide data in memory
- strings + grep is often faster than full Volatility analysis
