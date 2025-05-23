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
- Terminal scripts require an active X session and a compatible terminal emulator.
- Only use background scripts if you have no intent to later view or interact with the script.
- All scripts execute as root. Only install on secure systems to prevent privilege escalation

## Prerequisites

- Linux distribution with systemd
- Konsole or lxterminal (for terminal scripts)
- GNU Screen (for screen sessions)
- User permissions to create systemd services

## How to install

```
mkdir -p ~/startup
git clone https://github.com/sq1000000/AutoRun.git ~/startup
cd ~/startup/internals/other
./install_service.sh $USER
cd $HOME
```

## How to uninstall

```
cd ~/startup/internals/other
./uninstall_service.sh
rm -rf ~/startup
cd $HOME
```
