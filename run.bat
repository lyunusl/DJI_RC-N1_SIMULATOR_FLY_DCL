@echo off
setlocal EnableExtensions
cd /d "%~dp0"

set "APP_NAME=DJI RC-N1 Simulator Adapter"
set "PYTHON_VERSION=3.11.9"
set "PYTHON_INSTALLER_URL=https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%-amd64.exe"
set "PYTHON_INSTALLER=.tools\python-%PYTHON_VERSION%-amd64.exe"
set "SETUP_ONLY=0"

if /i "%~1"=="--setup-only" (
    set "SETUP_ONLY=1"
)

echo %APP_NAME%
echo.

call :find_python
if errorlevel 1 (
    call :install_python
    if errorlevel 1 goto :error
    call :find_python
    if errorlevel 1 (
        echo Python was installed, but this script still cannot find it.
        echo Close this window and run run.bat again.
        goto :error
    )
)

call :ensure_environment
if errorlevel 1 goto :error

if "%SETUP_ONLY%"=="1" (
    echo.
    echo Setup complete.
    echo Run run.bat to start the adapter.
    echo.
    pause
    exit /b 0
)

echo Starting adapter...
echo Close the adapter window to stop it.
echo.
start "%APP_NAME%" /high /wait ".venv\Scripts\python.exe" "main.py" %*

if errorlevel 1 (
    echo.
    echo The adapter stopped with an error.
    echo If the controller is not found, connect it through the bottom USB-C port and close DJI Assistant 2.
    echo.
    pause
    exit /b 1
)

exit /b 0

:find_python
set "PY_CMD="

where py >nul 2>nul
if not errorlevel 1 (
    py -3 -c "import sys; raise SystemExit(0 if sys.version_info >= (3, 9) else 1)" >nul 2>nul
    if not errorlevel 1 (
        set "PY_CMD=py -3"
        exit /b 0
    )
)

where python >nul 2>nul
if not errorlevel 1 (
    python -c "import sys; raise SystemExit(0 if sys.version_info >= (3, 9) else 1)" >nul 2>nul
    if not errorlevel 1 (
        set "PY_CMD=python"
        exit /b 0
    )
)

for %%P in (
    "%LocalAppData%\Programs\Python\Python313\python.exe"
    "%LocalAppData%\Programs\Python\Python312\python.exe"
    "%LocalAppData%\Programs\Python\Python311\python.exe"
    "%LocalAppData%\Programs\Python\Python310\python.exe"
    "%LocalAppData%\Programs\Python\Python39\python.exe"
) do (
    if exist "%%~fP" (
        "%%~fP" -c "import sys; raise SystemExit(0 if sys.version_info >= (3, 9) else 1)" >nul 2>nul
        if not errorlevel 1 (
            set "PY_CMD="%%~fP""
            exit /b 0
        )
    )
)

exit /b 1

:install_python
echo Python 3.9 or newer was not found.
echo Downloading Python %PYTHON_VERSION% from python.org...
echo.

if not exist ".tools" mkdir ".tools"

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri '%PYTHON_INSTALLER_URL%' -OutFile '%PYTHON_INSTALLER%'"
if errorlevel 1 (
    echo Failed to download Python.
    echo Check your internet connection and try again.
    exit /b 1
)

echo Installing Python for the current user...
"%PYTHON_INSTALLER%" /quiet InstallAllUsers=0 PrependPath=1 Include_launcher=1 Include_pip=1 Include_test=0
if errorlevel 1 (
    echo Python installation failed.
    exit /b 1
)

echo Python installation complete.
echo.
exit /b 0

:ensure_environment
if not exist ".venv\Scripts\python.exe" (
    echo Creating local Python environment...
    %PY_CMD% -m venv .venv
    if errorlevel 1 (
        echo Failed to create the local Python environment.
        exit /b 1
    )
)

".venv\Scripts\python.exe" -c "import serial, vgamepad" >nul 2>nul
if errorlevel 1 (
    echo Installing adapter dependencies...
    ".venv\Scripts\python.exe" -m pip install --upgrade pip
    if errorlevel 1 (
        echo Failed to upgrade pip.
        exit /b 1
    )

    ".venv\Scripts\python.exe" -m pip install -r requirements.txt
    if errorlevel 1 (
        echo Failed to install dependencies.
        exit /b 1
    )
)

exit /b 0

:error
echo.
echo Setup failed.
echo.
pause
exit /b 1
