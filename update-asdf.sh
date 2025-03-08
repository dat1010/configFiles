#!/bin/bash

set -e

# Usage help

if [ -z "$1" ]; then
  echo "Usage: $0 <asdf-version>"
  exit 1
fi

VERSION="$1"
BINDIR="$HOME/bin"
ASDF_BIN="$BINDIR/asdf"

# Define two possible asset URLs.
PRIMARY_URL="https://github.com/asdf-vm/asdf/releases/download/v${VERSION}/asdf-v${VERSION}-linux-amd64"
FALLBACK_URL="https://github.com/asdf-vm/asdf/releases/download/v${VERSION}/asdf-v${VERSION}-linux-amd64.tar.gz"

download_asset() {
  local url="$1"
  local dest="$2"
  echo "Downloading binary from: $url"
  curl -L "$url" -o "$dest"
}

echo "Updating asdf to version ${VERSION}..."
mkdir -p "$BINDIR"

# Create a temporary file for download
TMP_FILE=$(mktemp)

# Attempt to download from the primary URL.
download_asset "$PRIMARY_URL" "$TMP_FILE"

# Get file size and type.
FILE_SIZE=$(stat -c%s "$TMP_FILE")
FILE_TYPE=$(file -b "$TMP_FILE")
echo "DEBUG: Primary download file size: $FILE_SIZE bytes"
echo "DEBUG: Primary download file type: $FILE_TYPE"

# If the file is suspiciously small or not an ELF binary, try the fallback URL.
if [ "$FILE_SIZE" -lt 100 ] || ! echo "$FILE_TYPE" | grep -qi "ELF"; then
  echo "Primary asset did not yield a valid ELF binary. Trying fallback URL..."
  rm "$TMP_FILE"
  TMP_FILE=$(mktemp)
  download_asset "$FALLBACK_URL" "$TMP_FILE"
  FILE_SIZE=$(stat -c%s "$TMP_FILE")
  FILE_TYPE=$(file -b "$TMP_FILE")
  echo "DEBUG: Fallback download file size: $FILE_SIZE bytes"
  echo "DEBUG: Fallback download file type: $FILE_TYPE"
fi

# Process the downloaded file.
if echo "$FILE_TYPE" | grep -qi "gzip compressed data"; then
  echo "Detected a tar.gz archive. Extracting..."
  EXTRACT_DIR=$(mktemp -d)
  tar -xzvf "$TMP_FILE" -C "$EXTRACT_DIR"
  # Assume the binary is named "asdf" in the archive.
  if [ -f "$EXTRACT_DIR/asdf" ]; then
    mv "$EXTRACT_DIR/asdf" "$ASDF_BIN"
  else
    echo "Error: asdf binary not found in the extracted archive."
    rm -rf "$EXTRACT_DIR" "$TMP_FILE"
    exit 1
  fi
  rm -rf "$EXTRACT_DIR"
elif echo "$FILE_TYPE" | grep -qi "ELF"; then
  mv "$TMP_FILE" "$ASDF_BIN"
else
  echo "Error: Downloaded file is neither a valid ELF binary nor a tar.gz archive."
  rm "$TMP_FILE"
  exit 1
fi

chmod +x "$ASDF_BIN"

echo "asdf updated to version ${VERSION} successfully."
echo "Verifying installation..."
"$ASDF_BIN" --version


