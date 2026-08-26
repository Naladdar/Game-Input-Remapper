@echo off
setlocal
cd /d "%~dp0"
start "Game Input Remapper" powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -WindowStyle Hidden -File "%~dp0GameInputRemapper.ps1"
exit /b 0
