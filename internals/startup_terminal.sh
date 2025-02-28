#!/bin/bash
# startup_terminal.sh - Open terminal tabs/windows to run scripts from the terminal directory.
# Uses the default shell ($SHELL) and respects the terminal emulator defined in variables.yaml.

BASEDIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_DIR="$BASEDIR/../terminal"
VARIABLES_FILE="$BASEDIR/variables.yaml"

# Handle no scripts gracefully
shopt -s nullglob
SCRIPTS=("$SCRIPT_DIR"/*.sh)
shopt -u nullglob

if [ ${#SCRIPTS[@]} -eq 0 ]; then
    echo "No scripts found in $SCRIPT_DIR. Exiting."
    exit 0
fi

# Read terminal emulator from variables.yaml (default: konsole)
if [ -f "$VARIABLES_FILE" ]; then
    TERMINAL_EMULATOR=$(awk -F": " '/^terminal:/{print $2}' "$VARIABLES_FILE" | xargs)
else
    TERMINAL_EMULATOR="konsole"
fi

# Trim whitespace and lowercase for consistency
TERMINAL_EMULATOR=$(echo "$TERMINAL_EMULATOR" | tr '[:upper:]' '[:lower:]' | xargs)

case "$TERMINAL_EMULATOR" in
    konsole)
        # Konsole: Open first script in new window, others in tabs
        konsole --noclose -e "$SHELL" -c "$SHELL \"${SCRIPTS[0]}\"; exec $SHELL" &
        
        # Open remaining scripts in new tabs after a short delay
        for ((i = 1; i < ${#SCRIPTS[@]}; i++)); do
            sleep 0.3
            konsole --new-tab -e "$SHELL" -c "$SHELL \"${SCRIPTS[i]}\"; exec $SHELL" &
        done
        ;;

    lxterminal|*)
        # LXTerminal (or fallback): Open each script in a new window
        for SCRIPT in "${SCRIPTS[@]}"; do
            "$TERMINAL_EMULATOR" -e "$SHELL" -c "$SHELL \"$SCRIPT\"; exec $SHELL" &
        done
        ;;
esac
