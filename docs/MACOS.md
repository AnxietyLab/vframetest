# vframetest on macOS

Complete guide for installing and using vframetest on macOS (Apple Silicon and Intel Macs).

## Installation

### Pre-Built Binary (Recommended)

```bash
curl -L -O https://github.com/ssotoa70/vframetest/releases/download/v3025.10.2/vframetest-macos-universal
chmod +x vframetest-macos-universal
sudo mv vframetest-macos-universal /usr/local/bin/vframetest
vframetest --version
```

### Build from Source

```bash
xcode-select --install  # If not already installed
git clone https://github.com/ssotoa70/vframetest.git
cd vframetest
make clean && make
./build/vframetest --version
```

## macOS-Specific Features

- **F_NOCACHE**: Native direct I/O bypass (instead of fake O_DIRECT)
- **F_FULLFSYNC**: Ensures data reaches physical disk for accurate benchmarking
- **Universal Binary**: Works on both Apple Silicon (M1/M2/M3) and Intel Macs

## Usage Examples

### Simple Write Test

```bash
mkdir test-data
vframetest -w FULLHD-24bit -n 100 test-data
```

### Multi-Threaded Write

```bash
vframetest -w 4K-24bit -n 500 -t 4 test-data
```

### CSV Export

```bash
vframetest -w FULLHD-24bit -n 200 -t 2 -c test-data > results.csv
```

### Performance Timing Breakdown

```bash
vframetest -w 2K-24bit -n 100 -t 4 --times test-data
```

### Read Test

```bash
# First write frames
vframetest -w FULLHD-24bit -n 200 test-data
# Then read them back
vframetest -r -n 200 test-data
```

### Random Access Test

```bash
vframetest -r -n 100 --random test-data
```

### Performance Histogram

```bash
vframetest -w FULLHD-24bit -n 500 -t 4 --histogram test-data
```

## Troubleshooting

### "Permission denied"
```bash
chmod +x vframetest
```

### "No space left on device"
```bash
df -h  # Check disk space
rm -rf test-data/*  # Clean up old data
```

### Slow performance
- Close background applications
- Check available disk space
- Reduce number of threads (-t 2)
- Use external fast drive for testing

## Performance Tips

1. Use universal binary for compatibility
2. Test on both Apple Silicon and Intel if possible
3. Ensure 1+ GB free disk space
4. Close other applications for consistent results
5. Test on both internal and external drives

For detailed documentation, see the main README.md file.
