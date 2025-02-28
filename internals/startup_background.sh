#!/bin/bash
# Determine the base directory (where this script is located)
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Directory containing the background scripts
SCRIPT_DIR="$BASEDIR/../background"

# Handle no scripts gracefully
shopt -s nullglob
SCRIPTS=("$SCRIPT_DIR"/*.sh)
shopt -u nullglob

if [ ${#SCRIPTS[@]} -eq 0 ]; then
    echo "No scripts found in $SCRIPT_DIR. Exiting."
    exit 0
fi

# Iterate through each shell script in the directory and run it in the background using the default shell.
for SCRIPT in "${SCRIPTS[@]}"; do
  "$SHELL" "$SCRIPT" &
done
