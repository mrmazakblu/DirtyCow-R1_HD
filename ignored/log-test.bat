@echo off
echo Files Do not match Expected && echo %date% %time% [I] Files pushed to phone do not match reference. >> "%~dp0\dirty-cow-log\log.txt"
pause
:error
echo Image File not Found!! && echo %date% %time% [W] No files found in the pushed folder, Or pushed folder nor where expected. Expected location is "%~dp0 pushed" >> "%~dp0\dirty-cow-log\log.txt"
pause
