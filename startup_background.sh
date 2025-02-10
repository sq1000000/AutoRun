#!/bin/bash
# Determine the base directory (where this script is located)
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Directory containing the background scripts
SCRIPT_DIR="$BASEDIR/background"

# Iterate through each shell script in the directory and run it in the background using the default shell.
for SCRIPT in "$SCRIPT_DIR"/*.sh; do
  "$SHELL" "$SCRIPT" &
done

