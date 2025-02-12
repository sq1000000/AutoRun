#!/bin/bash
# uninstall_service.sh - Uninstalls the startup service from systemd.
#
# This script will:
#   1. Disable the startup service.
#   2. Stop the service if it is currently running.
#   3. Remove the service unit file from /etc/systemd/system.
#   4. Reload the systemd daemon to apply changes.
#
# Usage: ./uninstall_service.sh

SERVICE_NAME="startup.service"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}"

# Check if the service unit file exists
if [ ! -f "$SERVICE_FILE" ]; then
    echo "Error: $SERVICE_FILE not found. The service may not be installed."
    exit 1
fi

# Disable the service
echo "Disabling ${SERVICE_NAME}..."
sudo systemctl disable "$SERVICE_NAME"
if [ $? -ne 0 ]; then
    echo "Warning: Could not disable ${SERVICE_NAME}. It might not have been enabled."
fi

# Stop the service if it's running
echo "Stopping ${SERVICE_NAME} (if running)..."
sudo systemctl stop "$SERVICE_NAME" 2>/dev/null

# Remove the service unit file
echo "Removing ${SERVICE_FILE}..."
sudo rm "$SERVICE_FILE"
if [ $? -ne 0 ]; then
    echo "Error: Could not remove ${SERVICE_FILE}."
    exit 1
fi

# Reload systemd to update changes
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

echo "${SERVICE_NAME} has been uninstalled successfully."

