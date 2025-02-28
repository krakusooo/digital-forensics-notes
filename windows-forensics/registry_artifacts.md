# Windows Registry Forensics

## Key Forensic Locations

### Persistence mechanisms
```
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
HKLM\SYSTEM\CurrentControlSet\Services  (services/drivers)
```

### Recently accessed files (MRU)
```
HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs
HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU
```

### USB devices
```
HKLM\SYSTEM\CurrentControlSet\Enum\USBSTOR
HKLM\SYSTEM\CurrentControlSet\Enum\USB
```

### Network history
```
HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles
HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures
```

### User activity
```
HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\UserAssist
HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths
```

## Volatility Registry Commands
```bash
vol -f memory.dmp windows.registry.hivelist
vol -f memory.dmp windows.registry.printkey --key "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
vol -f memory.dmp windows.registry.userassist
```
