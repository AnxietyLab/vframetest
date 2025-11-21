# vframetest on Windows

Complete guide for installing and using vframetest on Windows 10/11 and Windows Server.

## Installation

### Pre-Built Binary

```powershell
# Create installation directory
New-Item -ItemType Directory -Force -Path "C:\Program Files\vframetest"

# Download binary
$url = "https://github.com/ssotoa70/vframetest/releases/download/v3025.10.2/vframetest-windows-x86_64.exe"
$dest = "C:\Program Files\vframetest\vframetest.exe"
Invoke-WebRequest -Uri $url -OutFile $dest
Unblock-File -Path $dest

# Add to PATH
[Environment]::SetEnvironmentVariable("Path",$env:Path+";C:\Program Files\vframetest","Machine")

# Verify
vframetest --version
```

### Build from Source (WSL2)

```bash
wsl --install -d Ubuntu
wsl -d Ubuntu -- bash -c "sudo apt-get update && sudo apt-get install -y build-essential git && git clone https://github.com/ssotoa70/vframetest.git && cd vframetest && make"
```

## Windows-Specific Features

- **FILE_FLAG_NO_BUFFERING**: Direct I/O access to storage
- **FILE_FLAG_WRITE_THROUGH**: Ensures data reaches disk
- **Works on**: Windows 10/11 and Windows Server 2019/2022

## Usage Examples

### Simple Write Test

```powershell
mkdir test-data
vframetest -w FULLHD-24bit -n 100 test-data
```

### Multi-Threaded Write

```powershell
vframetest -w 4K-24bit -n 500 -t 4 test-data
```

### CSV Export

```powershell
vframetest -w FULLHD-24bit -n 200 -t 2 -c test-data | Out-File results.csv
```

### Sequential Read

```powershell
# First write frames
vframetest -w FULLHD-24bit -n 200 test-data
# Then read them back
vframetest -r -n 200 test-data
```

### Random Access Read

```powershell
vframetest -r -n 100 --random test-data
```

## Performance Monitoring

### Using Task Manager

1. Open Task Manager (Ctrl+Shift+Esc)
2. Go to Performance tab
3. Watch Disk and CPU usage during test

### Using PowerShell

```powershell
Get-Counter -Counter "\PhysicalDisk(_Total)\Disk Read Bytes/sec" -Continuous
```

## Performance Tips

1. Disable antivirus/Windows Defender during benchmarking
2. Disable Spotlight indexing on test folder
3. Close disk-intensive applications
4. Run with administrator privileges
5. Use local SSD for testing

## Troubleshooting

### "Access Denied"
```powershell
# Run PowerShell as Administrator
Start-Process powershell -Verb RunAs
```

### "File is blocked"
```powershell
Unblock-File -Path "C:\Program Files\vframetest\vframetest.exe"
```

### "Drive full"
```powershell
# Check available space
Get-PSDrive | Select-Object Name,Used,Free

# Clean up old data
Remove-Item -Recurse -Force test-data\*
```

### Slow performance
- Disable antivirus temporarily
- Close background applications
- Check Task Manager for system load
- Reduce thread count (-t 2)

For detailed documentation, see the main README.md file.
