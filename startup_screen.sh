#!/bin/bash
# Determine the base directory (where this script is located)
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Directory containing the screen scripts
SCRIPT_DIR="$BASEDIR/screen"

# Iterate through each shell script in the directory
for SCRIPT in "$SCRIPT_DIR"/*.sh; do
  # Get the base name of the script (without directory and extension)
  SCRIPT_NAME=$(basename "$SCRIPT" .sh)
  
  # Create a new screen session and run the script using the default shell.
  # The command executed is: $SHELL "$SCRIPT"; exec $SHELL
  screen -dmS "$SCRIPT_NAME" "$SHELL" -c "$SHELL \"$SCRIPT\"; exec $SHELL"
done

