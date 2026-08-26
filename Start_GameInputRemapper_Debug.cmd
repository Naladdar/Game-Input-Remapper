@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -File "%~dp0GameInputRemapper.ps1"
echo.
echo If an error was shown above, copy the complete text when reporting the problem.
pause
