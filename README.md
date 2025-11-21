# vframetest

[![CI/CD](https://github.com/ssotoa70/vframetest/actions/workflows/ci.yml/badge.svg)](https://github.com/ssotoa70/vframetest/actions/workflows/ci.yml)

Professional media frame I/O benchmark and testing tool for cross-platform storage performance evaluation.

**vframetest** is a high-performance benchmarking utility designed to accurately measure disk I/O performance when writing and reading media frames. Perfect for validating storage subsystems, video workflows, and data center configurations.

## Key Features

- 🎯 **Accurate I/O Benchmarking** - Native direct I/O on all platforms
- 🖥️ **Cross-Platform** - macOS, Linux, and Windows with native optimizations
- 📊 **Flexible Testing** - Multiple video profiles, multi-threaded testing
- 📈 **Rich Output** - CSV export, histograms, detailed timing
- ⚡ **High Performance** - Configurable parallelism and threading
- 📦 **Easy to Use** - Pre-built binaries and simple build process

## Quick Start

### macOS
```bash
curl -L -O https://github.com/ssotoa70/vframetest/releases/download/v25.11.22/vframetest-macos-universal
chmod +x vframetest-macos-universal
mkdir test-data
./vframetest-macos-universal -w FULLHD-24bit -n 100 -t 4 test-data
```

### Linux
```bash
wget https://github.com/ssotoa70/vframetest/releases/download/v25.11.22/vframetest-linux-x86_64
chmod +x vframetest-linux-x86_64
mkdir test-data
./vframetest-linux-x86_64 -w FULLHD-24bit -n 100 -t 4 test-data
```

### Windows
```powershell
Invoke-WebRequest -Uri "https://github.com/ssotoa70/vframetest/releases/download/v25.11.22/vframetest-windows-x86_64.exe" -OutFile "vframetest.exe"
mkdir test-data
.\vframetest.exe -w FULLHD-24bit -n 100 -t 4 test-data
```

## Installation

### macOS (Homebrew)
```bash
# Install via Homebrew tap
brew tap ssotoa70/vframetest https://github.com/ssotoa70/vframetest
brew install vframetest

# Verify installation
vframetest --version
```

### macOS (Manual)
```bash
# Pre-built binary
curl -L -O https://github.com/ssotoa70/vframetest/releases/download/v25.11.22/vframetest-macos-universal
chmod +x vframetest-macos-universal
sudo mv vframetest-macos-universal /usr/local/bin/vframetest

# Build from source
git clone https://github.com/ssotoa70/vframetest.git
cd vframetest
make clean && make
```

### Linux
```bash
# Pre-built binary
wget https://github.com/ssotoa70/vframetest/releases/download/v25.11.22/vframetest-linux-x86_64
chmod +x vframetest-linux-x86_64
sudo mv vframetest-linux-x86_64 /usr/local/bin/vframetest

# Build from source (Ubuntu/Debian)
sudo apt-get install build-essential git
git clone https://github.com/ssotoa70/vframetest.git
cd vframetest
make clean && make

# Build from source (RHEL/CentOS)
sudo yum groupinstall "Development Tools"
sudo yum install git
git clone https://github.com/ssotoa70/vframetest.git
cd vframetest
make clean && make
```

### Windows
```powershell
# Pre-built binary
$url = "https://github.com/ssotoa70/vframetest/releases/download/v25.11.22/vframetest-windows-x86_64.exe"
$dest = "C:\Program Files\vframetest\vframetest.exe"
New-Item -ItemType Directory -Force -Path "C:\Program Files\vframetest"
Invoke-WebRequest -Uri $url -OutFile $dest
Unblock-File -Path $dest

# Build from source (WSL2)
wsl --install -d Ubuntu
wsl -d Ubuntu -- bash -c "sudo apt-get update && sudo apt-get install -y build-essential git && git clone https://github.com/ssotoa70/vframetest.git && cd vframetest && make"
```

## Usage

```bash
# Show help
vframetest --help

# List profiles
vframetest --list-profiles

# Simple write test
mkdir test-data
vframetest -w FULLHD-24bit -n 100 test-data

# Multi-threaded write
vframetest -w 4K-24bit -n 500 -t 4 test-data

# CSV export
vframetest -w FULLHD-24bit -n 200 -t 2 -c test-data > results.csv

# Read test
vframetest -r -n 200 test-data

# Random access
vframetest -r -n 100 --random test-data

# Performance histogram
vframetest -w FULLHD-24bit -n 500 -t 4 --histogram test-data
```

## Machine-Readable Output (JSON & CSV)

Export results for automation and analysis:

```bash
# JSON format (pretty-printed, structured data)
vframetest --json -w FULLHD-24bit -n 100 test-data > results.json

# CSV format (comma-separated, importable to spreadsheets)
vframetest --csv -w FULLHD-24bit -n 100 test-data > results.csv

# CSV with timing breakdown
vframetest --csv --times -w FULLHD-24bit -n 100 test-data > results_detailed.csv

# Skip CSV header for appending multiple runs
vframetest --csv --no-csv-header -w FULLHD-24bit -n 100 test-data >> results.csv
```

### JSON Output Example
```json
{
  "results": [
    {
      "case": "write",
      "profile": "FULLHD-24bit",
      "threads": 1,
      "frames": 100,
      "bytes": 628736000,
      "time_ns": 1234567890,
      "fps": 81.015625,
      "bps": 509664514.285714,
      "mibps": 486.023430,
      "completion": {
        "min_ms": 5.908000,
        "avg_ms": 12.345600,
        "max_ms": 25.641000
      }
    }
  ]
}
```

### CSV Output Example
```csv
case,profile,threads,frames,bytes,time,fps,bps,mibps,fmin,favg,fmax
"write","FULLHD-24bit",1,100,628736000,1234567890,81.015625,509664514.285714,486.023430,5908000,12345600.000000,25641000
```

## Platform-Specific Features

- **macOS**: F_NOCACHE for native direct I/O, F_FULLFSYNC for data integrity, Universal Binary support
- **Linux**: O_DIRECT for kernel-bypass I/O, full POSIX support, multiple architecture support
- **Windows**: FILE_FLAG_NO_BUFFERING for direct access, FILE_FLAG_WRITE_THROUGH for data durability

## Documentation

- `README.md` - This file
- `docs/MACOS.md` - macOS installation and usage guide
- `docs/LINUX.md` - Linux installation and usage guide
- `docs/WINDOWS.md` - Windows installation and usage guide
- `BUILD.md` - Building from source for all platforms

## CI/CD Pipeline

This project uses GitHub Actions for continuous integration:

- **Build**: Compiles on macOS (universal binary), Linux (x86_64), and Windows (x86_64 + i686)
- **Test**: Runs unit tests on Linux and macOS
- **Release**: Automatically creates releases with binaries for all platforms when tags are pushed
- **Benchmarking**: Automatically collects build performance metrics for all platforms

Releases are created automatically when you push a version tag:
```bash
git tag -a v25.11.22 -m "Release v25.11.22"
git push origin v25.11.22
```

## Benchmarking Dashboard

Monitor build performance and metrics with the automated benchmarking dashboard:

### Features
- 📊 Real-time build performance visualization
- 📈 Success rates and duration trends
- 🎯 Platform comparison (macOS vs Linux)
- 📱 Responsive design for mobile and desktop

### Viewing the Dashboard
```bash
# Open locally
open dashboard/index.html

# Or use HTTP server
python3 -m http.server 8000
# Navigate to http://localhost:8000/dashboard/
```

### Dashboard Data
Build metrics are automatically collected in `dashboard/data/builds.json`:
- Build duration per platform
- Success/failure status
- Version and commit information
- Timestamps for historical analysis

For detailed dashboard documentation, see [dashboard/README.md](dashboard/README.md)

## Performance Tips

### macOS
1. Use the universal binary for compatibility
2. Ensure 1+ GB free disk space
3. Close background applications
4. Test on both internal and external drives

### Linux
1. Use dedicated fast storage when possible
2. Monitor I/O: `iostat -x 1` during test
3. Disable unnecessary services
4. Check for thermal throttling

### Windows
1. Disable antivirus/Windows Defender during benchmarking
2. Disable Spotlight indexing on test folder
3. Close disk-intensive applications
4. Run with administrator privileges

## System Requirements

- **macOS**: 11.0 or later, Apple Silicon or Intel
- **Linux**: glibc 2.28+, x86_64 or ARM64
- **Windows**: Windows 10 (Build 1909+) or Windows Server 2019+
- **Disk**: 500 MB free minimum, 2-5 GB recommended for testing

## License

GNU General Public License v2 or later. See COPYING file.

## Support

- **Documentation**: See `docs/` folder for detailed platform guides
- **Issues**: Report on GitHub
- **Questions**: Check documentation files

---

**vframetest 25.11.21** - Built with native platform optimizations
