#!/bin/bash
#
# persist
#
# A helper utility to install an apt package AND persist it to the g-shell apt.list
# Usage: persist <package_name>

set -e

if [ -z "$1" ]; then
    echo "Usage: persist <package_name>"
    exit 1
fi

PACKAGE_NAME="$1"
APT_LIST="${HOME}/g-shell/packages/apt.list"

# 1. Install the package immediately
echo "Installing $PACKAGE_NAME..."
sudo apt-get install -y "$PACKAGE_NAME"

# 2. Add to list if not already there
if ! grep -q "^$PACKAGE_NAME$" "$APT_LIST"; then
    echo "Persisting $PACKAGE_NAME to $APT_LIST..."
    echo "$PACKAGE_NAME" >> "$APT_LIST"
    echo "Done. $PACKAGE_NAME will be re-installed on next boot."
else
    echo "$PACKAGE_NAME is already in the persistence list."
fi
