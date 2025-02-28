#!/bin/bash
# install_service.sh - Replace all instances of 'pi' with the provided username,
# copy the modified file to /etc/systemd/system, and enable the service.
#
# Usage: ./install_service.sh <username>

# Check that exactly one argument was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

NEW_USER="$1"
INPUT_FILE="startup.service"
MODIFIED_FILE="startup.service.modified"

# Ensure the input file exists in the current directory
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: $INPUT_FILE not found!"
    exit 1
fi

# Replace all occurrences of "pi" with the new username and write to the modified file
sed "s/pi/${NEW_USER}/g" "$INPUT_FILE" > "$MODIFIED_FILE"
echo "Modified service file created as $MODIFIED_FILE for user $NEW_USER."

# Move the modified file to /etc/systemd/system (requires sudo privileges)
echo "Moving $MODIFIED_FILE to /etc/systemd/system/startup.service..."
sudo mv "$MODIFIED_FILE" /etc/systemd/system/startup.service
if [ $? -ne 0 ]; then
    echo "Error: Failed to move the modified service file."
    exit 1
fi

# Convert the final file to Unix-style line endings
if command -v dos2unix >/dev/null 2>&1; then
    sudo dos2unix /etc/systemd/system/startup.service
    echo "Converted /etc/systemd/system/startup.service to Unix-style line endings."
else
    echo "Warning: dos2unix not installed. Line endings were not converted."
fi

# Reload systemd to recognize the new service unit file
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable the service so it starts automatically on boot
echo "Enabling startup.service..."
sudo systemctl enable startup.service
if [ $? -ne 0 ]; then
    echo "Error: Failed to enable startup.service."
    exit 1
fi

echo "Service installed and enabled successfully."
