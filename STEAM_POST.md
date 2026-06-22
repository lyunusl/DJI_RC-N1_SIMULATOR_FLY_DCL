# Steam Discussion Draft

## Title

DJI RC-N1 controller adapter for DCL / PC simulators

## Post

Hi everyone,

I put together a small Windows helper for people who want to use a DJI RC-N1 controller with DCL or other PC simulators.

It reads the DJI RC-N1 controller through the DJI USB VCOM "For Protocol" serial port and exposes it to Windows as a virtual Xbox 360 gamepad.

What it does:

- Automatically finds the DJI `For Protocol` serial port.
- Enables simulator mode on the controller.
- Maps the sticks to a virtual Xbox 360 controller.
- Runs with high process priority to reduce input delay.
- Does not ship as a signed `.exe`; it is a simple Python + batch script package so the code is easy to inspect.

Basic setup:

1. Install DJI Assistant 2 for Consumer Drones so the USB VCOM driver is available.
2. Close DJI Assistant 2.
3. Connect the RC-N1 through the bottom USB-C port.
4. Run `run.bat`.
5. Select the Xbox 360 controller inside the simulator.

`run.bat` handles the setup automatically. If Python is missing, it downloads and installs Python 3.11.9 from python.org for the current Windows user, creates a local virtual environment, installs the required packages, and starts the adapter.

Expected Windows ports:

```text
DEVICE USB VCOM For Protocol (COMx)
DEVICE USB VCOM For Debug (COMx)
```

The adapter uses the `For Protocol` port.

I am sharing it because this setup can be annoying to get working, and this should save time for others running into the same issue.

Download / source:

```text
PASTE_GITHUB_OR_DOWNLOAD_LINK_HERE
```

Notes:

- Windows only.
- Tested with DJI RC-N1 / RC231 style controller.
- Tested with DCL.
- This is not an official DJI tool.
- Use at your own risk.
