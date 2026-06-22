@echo off
setlocal
cd /d "%~dp0"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$project = (Resolve-Path '.').Path; " ^
  "$desktop = [Environment]::GetFolderPath('Desktop'); " ^
  "$lnk = Join-Path $desktop 'DJI RC-N1 Simulator Adapter.lnk'; " ^
  "$target = Join-Path $project 'run.bat'; " ^
  "$icon = Join-Path $project 'DJI-RC-N1-Simulator.ico'; " ^
  "$shell = New-Object -ComObject WScript.Shell; " ^
  "$shortcut = $shell.CreateShortcut($lnk); " ^
  "$shortcut.TargetPath = $target; " ^
  "$shortcut.WorkingDirectory = $project; " ^
  "$shortcut.IconLocation = $icon + ',0'; " ^
  "$shortcut.Description = 'DJI RC-N1 Simulator Adapter'; " ^
  "$shortcut.Save(); " ^
  "Write-Host 'Desktop shortcut created:' $lnk"

if errorlevel 1 (
    echo Failed to create the desktop shortcut.
    pause
    exit /b 1
)

echo.
pause
