#!/bin/bash
# Determine the directory where this script resides
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Run the terminal scripts
"$BASEDIR/startup_terminal.sh" &

# Run the screen scripts
"$BASEDIR/startup_screen.sh" &

# Run the background scripts
"$BASEDIR/startup_background.sh" &

