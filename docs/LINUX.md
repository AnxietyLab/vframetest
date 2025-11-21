# vframetest on Linux

Complete guide for installing and using vframetest on Linux (RHEL, CentOS, Ubuntu, Debian).

## Installation

### Pre-Built Binary

```bash
wget https://github.com/ssotoa70/vframetest/releases/download/v3025.10.2/vframetest-linux-x86_64
chmod +x vframetest-linux-x86_64
sudo mv vframetest-linux-x86_64 /usr/local/bin/vframetest
vframetest --version
```

### Build from Source

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y build-essential git
git clone https://github.com/ssotoa70/vframetest.git
cd vframetest
make clean && make
./build/vframetest --version
```

**RHEL/CentOS:**
```bash
sudo yum groupinstall -y "Development Tools"
sudo yum install -y git
git clone https://github.com/ssotoa70/vframetest.git
cd vframetest
make clean && make
./build/vframetest --version
```

## Linux-Specific Features

- **O_DIRECT**: Native Linux direct I/O for accurate disk benchmarking
- **Full POSIX Support**: Compatible with all Linux distributions
- **Architectures**: x86_64, ARM64, and others

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

### Sequential Read

```bash
# First write frames
vframetest -w FULLHD-24bit -n 200 test-data
# Then read them back
vframetest -r -n 200 test-data
```

### Random Access Read

```bash
vframetest -r -n 100 --random test-data
```

### Stress Test

```bash
vframetest -w FULLHD-24bit -n 10000 -t 8 test-data
```

## Performance Monitoring

```bash
# Monitor I/O during test
iostat -x 1

# Check disk usage
df -h /path/to/test

# Monitor CPU
top -p $(pgrep vframetest)
```

## Performance Tips

1. Use dedicated fast storage when possible
2. Monitor I/O: `iostat -x 1` during test
3. Disable unnecessary services
4. Check for thermal throttling on sustained tests
5. Clear filesystem cache between tests: `sync; echo 3 | sudo tee /proc/sys/vm/drop_caches`

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
- Check system load: `top`
- Monitor I/O: `iostat -x 1`
- Disable background tasks
- Check disk space

For detailed documentation, see the main README.md file.
