#!/bin/bash
# Usage: ./scripts/update-cask.sh <cask-name> <version> <download-url>
# Example: ./scripts/update-cask.sh linkswitch 1.1.0 https://github.com/kriuchkov/linkswitch/releases/download/v1.1.0/LinkSwitch.zip

set -e

CASK_NAME=$1
VERSION=$2
URL=$3

if [ -z "$CASK_NAME" ] || [ -z "$VERSION" ] || [ -z "$URL" ]; then
    echo "Usage: $0 <cask-name> <version> <download-url>"
    exit 1
fi

CASK_FILE="Casks/${CASK_NAME}.rb"

if [ ! -f "$CASK_FILE" ]; then
    echo "Error: Cask file $CASK_FILE not found"
    exit 1
fi

echo "Downloading $URL to calculate SHA256..."
SHA256=$(curl -sL "$URL" | shasum -a 256 | awk '{print $1}')

echo "SHA256: $SHA256"

# Update version
sed -i '' "s/version \".*\"/version \"$VERSION\"/" "$CASK_FILE"

# Update sha256
sed -i '' "s/sha256 \".*\"/sha256 \"$SHA256\"/" "$CASK_FILE"

echo "Updated $CASK_FILE:"
echo "  version: $VERSION"
echo "  sha256:  $SHA256"
echo ""
echo "Don't forget to commit and push:"
echo "  git add $CASK_FILE"
echo "  git commit -m \"Update $CASK_NAME to $VERSION\""
echo "  git push"
