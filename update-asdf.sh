#!/bin/bash
set -e

# Check for version argument
if [ -z "$1" ]; then
  echo "Usage: $0 <asdf-version>"
  exit 1
fi

VERSION="$1"
BINDIR="$HOME/bin"
ASDF_BIN="$BINDIR/asdf"
URL="https://github.com/asdf-vm/asdf/releases/download/v${VERSION}/asdf-v${VERSION}-linux-amd64"

# Create the target directory if it doesn't exist
mkdir -p "$BINDIR"

echo "Downloading asdf version ${VERSION} from ${URL}..."
curl -L "$URL" -o "$ASDF_BIN"

# Make the downloaded binary executable
chmod +x "$ASDF_BIN"

echo "asdf updated to version ${VERSION} successfully."
echo "Verifying installation..."
"$ASDF_BIN" --version


