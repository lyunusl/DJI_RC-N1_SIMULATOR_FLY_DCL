# Steam Discussion Draft - Liftoff

## Title

DJI RC-N1 controller adapter for Liftoff on Windows

## Post

Hi everyone,

I put together a small Windows helper for people who want to try using a DJI RC-N1 controller with Liftoff.

The adapter reads the DJI RC-N1 through the DJI USB VCOM `For Protocol` serial port and exposes the controller to Windows as a virtual Xbox 360 gamepad. Liftoff should then be able to see it as a normal controller input.

What it does:

- Automatically finds the DJI USB VCOM `For Protocol` port.
- Enables simulator mode on the RC-N1.
- Maps the sticks to a virtual Xbox 360 controller.
- Runs with high process priority to reduce input delay.
- Stays as a simple Python + batch script package instead of an unsigned `.exe`, so the code is easy to inspect and avoids SmartScreen installer warnings.

Basic setup:

1. Install DJI Assistant 2 for Consumer Drones so the USB VCOM driver is available.
2. Close DJI Assistant 2.
3. Connect the RC-N1 through the bottom USB-C port.
4. Run `run.bat`.
5. Open Liftoff and select/configure the Xbox 360 controller input.

`run.bat` handles the setup automatically. If Python is missing, it downloads and installs Python 3.11.9 from python.org for the current Windows user, creates a local virtual environment, installs the required packages, and starts the adapter.

Expected Windows serial ports:

```text
DEVICE USB VCOM For Protocol (COMx)
DEVICE USB VCOM For Debug (COMx)
```

The adapter uses the `For Protocol` port.

Download / source:

```text
PASTE_GITHUB_OR_DOWNLOAD_LINK_HERE
```

Notes:

- Windows only.
- Made for DJI RC-N1 / RC231 style controllers.
- This is not an official DJI or Liftoff tool.
- Use at your own risk.
- If you try it with Liftoff, please share whether the mapping feels correct or needs adjustment.
