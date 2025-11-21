#!/bin/bash
# Collect benchmark results from CI/CD run and update dashboard

set -e

# Configuration
DASHBOARD_DIR="$(dirname "$0")/../dashboard"
DATA_FILE="${DASHBOARD_DIR}/data/builds.json"
TEMP_FILE="${DASHBOARD_DIR}/data/.builds.json.tmp"

# Parameters (from GitHub Actions environment)
VERSION="${1:-$(grep '^MAJOR=' Makefile | cut -d= -f2).$(grep '^MINOR=' Makefile | cut -d= -f2).$(grep '^PATCH=' Makefile | cut -d= -f2)}"
PLATFORM="${2:-unknown}"
STATUS="${3:-unknown}"
DURATION="${4:-0}"
COMMIT="${GITHUB_SHA:0:7}"

# Validate inputs
if [[ -z "$VERSION" ]] || [[ "$PLATFORM" == "unknown" ]] || [[ "$STATUS" == "unknown" ]]; then
    echo "Usage: $0 <version> <platform> <status> <duration>"
    echo "  version: v25.11.21"
    echo "  platform: macOS|Linux"
    echo "  status: success|failure"
    echo "  duration: seconds (integer)"
    exit 1
fi

# Create benchmark entry
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Update JSON file (keep last 100 builds)
python3 - "$VERSION" "$PLATFORM" "$STATUS" "$DURATION" "$TIMESTAMP" "$COMMIT" "$DATA_FILE" <<'PYTHON'
import json
import sys
import os
from datetime import datetime

version = sys.argv[1]
platform = sys.argv[2]
status = sys.argv[3]
duration = int(sys.argv[4])
timestamp = sys.argv[5]
commit = sys.argv[6]
data_file = sys.argv[7]

# Create new entry
new_entry = {
    "date": timestamp,
    "version": version,
    "platform": platform,
    "status": status,
    "duration": duration,
    "commit": commit
}

# Load or create data
if os.path.exists(data_file):
    with open(data_file, 'r') as f:
        data = json.load(f)
else:
    data = []

# Prepend new entry
data.insert(0, new_entry)

# Keep only last 100 builds
data = data[:100]

# Write back
with open(data_file, 'w') as f:
    json.dump(data, f, indent=2)

print(f"Added build for {new_entry['platform']} ({new_entry['status']})")
PYTHON
if [ $? -ne 0 ]; then
    echo "Error updating benchmark data"
    exit 1
fi

echo "Build data updated: $DATA_FILE"
