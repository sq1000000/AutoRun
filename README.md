# AutoRun

This project is a systemd-based solution for managing startup scripts on Linux.
With this project, you can automatically runs your scripts:

- In a visible terminal window
- As background processes
- In GNU Screen sessions

## Usage

Place your scripts in the appropriate folders:

- `terminal/`: Runs in a graphical terminal window (requires desktop environment)
- `background/`: Runs as a background process
- `screen/`: Runs in a GNU Screen session

### Notes

- Make sure all scripts have been marked as executable with `chmod +x`.
- Terminal scripts require an active X session and a terminal emulator (e.g., Konsole or lxterminal).
- Only use background scripts if you have no intent to later view or interact with the script.

## Prerequisites

- Linux distribution with systemd
- Konsole or lxterminal (for terminal scripts)
- GNU Screen (for screen sessions)
- User permissions to create systemd services

## How to install

```
mkdir -p ~/startup
git clone https://github.com/sq1000000/AutoRun.git ~/startup
cd ~/startup/other
./install_service $USER
```

## How to uninstall

```
cd ~/startup/other
./uninstall_service
rm -rf ~/startup
cd $HOME
```
