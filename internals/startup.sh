#!/bin/bash
# Determine the directory where this script resides
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

# Run background scripts
"$BASEDIR/startup_background.sh" &

# Run screen scripts
"$BASEDIR/startup_screen.sh" &

# Run terminal scripts
"$BASEDIR/startup_terminal.sh" &
