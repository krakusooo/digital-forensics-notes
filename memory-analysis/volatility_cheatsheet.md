# Volatility3 Cheatsheet

## Basic Info
```bash
vol -f memory.dmp windows.info
vol -f memory.dmp windows.pslist
vol -f memory.dmp windows.pstree
```

## Process Analysis
```bash
# List processes
vol -f memory.dmp windows.pslist
vol -f memory.dmp windows.psscan        # finds hidden processes

# Process details
vol -f memory.dmp windows.cmdline
vol -f memory.dmp windows.dlllist --pid 1234

# Dump process memory
vol -f memory.dmp windows.memmap --pid 1234 --dump
```

## Network Artifacts
```bash
vol -f memory.dmp windows.netstat
vol -f memory.dmp windows.netscan
```

## Registry
```bash
vol -f memory.dmp windows.registry.hivelist
vol -f memory.dmp windows.registry.printkey --key "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
```

## Malware Analysis
```bash
vol -f memory.dmp windows.malfind          # find injected code
vol -f memory.dmp windows.handles --pid 1234
vol -f memory.dmp windows.vadinfo --pid 1234
```
