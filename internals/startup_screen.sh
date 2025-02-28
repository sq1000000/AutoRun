#!/bin/bash
# Determine the base directory (where this script is located)
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Directory containing the screen scripts
SCRIPT_DIR="$BASEDIR/../screen"

# Handle no scripts gracefully
shopt -s nullglob
SCRIPTS=("$SCRIPT_DIR"/*.sh)
shopt -u nullglob

if [ ${#SCRIPTS[@]} -eq 0 ]; then
    echo "No scripts found in $SCRIPT_DIR. Exiting."
    exit 0
fi

# Iterate through each shell script in the directory
for SCRIPT in "${SCRIPTS[@]}"; do
  # Get the base name of the script (without directory and extension)
  SCRIPT_NAME=$(basename "$SCRIPT" .sh)
  
  # Create a new screen session and run the script using the default shell.
  # The command executed is: $SHELL "$SCRIPT"; exec $SHELL
  screen -dmS "$SCRIPT_NAME" "$SHELL" -c "$SHELL \"$SCRIPT\"; exec $SHELL"
done
