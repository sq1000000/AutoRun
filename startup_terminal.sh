#!/bin/bash
# Determine the base directory (where this script is located)
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Directory containing the terminal scripts
SCRIPT_DIR="$BASEDIR/terminal"

# Path to the variables file
VARIABLES_FILE="$BASEDIR/variables.yaml"

# Read the terminal emulator from variables.yaml.
# Expected format in variables.yaml: terminal: lxterminal
if [ -f "$VARIABLES_FILE" ]; then
    TERMINAL_EMULATOR=$(awk -F": " '/^terminal:/{print $2}' "$VARIABLES_FILE")
else
    # Default to konsole if the variables file is not found.
    TERMINAL_EMULATOR="konsole"
fi

# Trim any leading/trailing whitespace.
TERMINAL_EMULATOR=$(echo "$TERMINAL_EMULATOR" | xargs)

if [ "$TERMINAL_EMULATOR" == "konsole" ]; then
    # For konsole, use DBus to open new tabs.
    konsole --noclose &
    sleep 2
    # Get the DBus service for konsole (assumes one is returned).
    KONSOLE_DBUS=$(qdbus | grep konsole | tail -1)

    # Get all scripts in the directory as an array.
    SCRIPTS=("$SCRIPT_DIR"/*.sh)

    # Run the first script in the existing tab (Session 1).
    qdbus "$KONSOLE_DBUS" /Sessions/1 runCommand "$SHELL \"${SCRIPTS[0]}\"; exec $SHELL"

    # Open the remaining scripts in new tabs.
    for ((i = 1; i < ${#SCRIPTS[@]}; i++)); do
      SESSION_ID=$(qdbus "$KONSOLE_DBUS" /Windows/1 newSession)
      sleep 1
      qdbus "$KONSOLE_DBUS" /Sessions/"$SESSION_ID" runCommand "$SHELL \"${SCRIPTS[i]}\"; exec $SHELL"
    done
else
    # For lxterminal (which does not support tabs natively), launch each script in a new window.
    # Each window runs the command: $SHELL "$SCRIPT"; exec $SHELL
    for SCRIPT in "$SCRIPT_DIR"/*.sh; do
         "$TERMINAL_EMULATOR" -e "$SHELL" -c "$SHELL \"$SCRIPT\"; exec $SHELL" &
    done
fi

