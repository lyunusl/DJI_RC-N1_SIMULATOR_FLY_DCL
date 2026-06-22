# DJI RC-N1 Simulator Adapter

Use a DJI RC-N1 remote controller as a virtual Xbox 360 gamepad on Windows.

This project is meant for people who want to fly PC simulators with the DJI RC-N1 controller and do not want to build or configure a full Python project by hand.

## What It Does

- Finds the DJI USB VCOM "For Protocol" serial port automatically.
- Enables RC simulator mode.
- Reads stick and camera wheel input from the controller.
- Sends the input to Windows as a virtual Xbox 360 controller through `vgamepad`.
- Runs with high process priority on Windows to reduce input delay.
- Keeps debug output off by default.

## Requirements

- Windows 10 or Windows 11.
- Internet access for first-time setup if Python is not already installed.
- DJI Assistant 2 for Consumer Drones installed, because it provides the required USB VCOM driver.
- A DJI RC-N1 controller connected through the bottom USB-C port.

Close DJI Assistant 2 before running this adapter. Only one app can usually use the controller serial port at a time.

## Quick Start

1. Download or clone this folder.
2. Install DJI Assistant 2 for Consumer Drones if the controller serial ports do not appear.
3. Connect the RC-N1 through the bottom USB-C port.
4. Run `run.bat`.
5. Open your simulator and select the Xbox 360 controller input.

`run.bat` handles the setup automatically:

- If Python 3.9 or newer is already installed, it uses it.
- If Python is missing, it downloads and installs Python 3.11.9 from python.org for the current Windows user.
- It creates a local `.venv` folder.
- It installs the required Python packages.
- It starts the adapter with high process priority.

Optional:

- Run `create_desktop_shortcut.bat` to create an icon shortcut on your desktop.

## Expected Serial Ports

When the controller is connected correctly, Windows should show ports similar to:

```text
DEVICE USB VCOM For Protocol (COM6)
DEVICE USB VCOM For Debug (COM7)
```

The adapter uses the `For Protocol` port.

You can list ports manually:

```bat
.venv\Scripts\python.exe -m serial.tools.list_ports -v
```

## Manual Run

The automatic run command is:

```bat
run.bat
```

If you need to force a specific port:

```bat
.venv\Scripts\python.exe main.py --port COM6
```

If you need diagnostic output:

```bat
.venv\Scripts\python.exe main.py --debug
```

## Troubleshooting

### The app says it cannot open COM9

The adapter did not find the DJI `For Protocol` port and fell back to the default port.

Fix:

1. Connect the controller through the bottom USB-C port.
2. Install DJI Assistant 2 for Consumer Drones.
3. Close DJI Assistant 2.
4. Run `run.bat` again.

### The controller appears as `For Debug` only

Use the bottom USB-C connection on the controller. The adapter needs the `For Protocol` port.

### The simulator does not see a controller

Run the automatic setup again:

```bat
run.bat
```

Windows should see a virtual Xbox 360 controller.

You can also run setup without starting the adapter:

```bat
install.bat
```

`install.bat` is only a compatibility wrapper for `run.bat --setup-only`.

### Input feels delayed

This version updates the virtual gamepad as soon as a valid controller packet is received. It also raises the Python process priority to `High` on Windows.

If a simulator still feels delayed:

- Close DJI Assistant 2.
- Close other controller mapping tools.
- Use a direct USB connection instead of a hub.
- Try another USB port.

## Notes

This project does not include a signed Windows `.exe` installer. That is intentional. The goal is to avoid SmartScreen issues and keep the code easy to inspect.

If Python is missing, `run.bat` downloads the official Python installer from python.org and installs it for the current user.

## Tested With

- DJI RC-N1 / RC231 style controller.
- DCL - The Game.

Recommended DCL preset:

```text
Mode 2
Acro
Zero throttle at stick center
```
