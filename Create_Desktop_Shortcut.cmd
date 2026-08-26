@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$ws=New-Object -ComObject WScript.Shell; $desktop=[Environment]::GetFolderPath('Desktop'); $s=$ws.CreateShortcut((Join-Path $desktop 'Game Input Remapper.lnk')); $s.TargetPath=(Join-Path '%~dp0' 'Start_GameInputRemapper.cmd'); $s.WorkingDirectory='%~dp0'; $s.Description='Game Input Remapper'; $s.Save()"
echo Desktop shortcut created.
pause
