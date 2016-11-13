@echo off
SET MTK_DRV_INST_VERSION=1.00

cls
echo **** Mediatek USB Driver Install v. %MTK_DRV_INST_VERSION%
echo.
rem echo Mediatek Dirver Installer v. %MTK_DRV_INST_VERSION%
for /f %%i in ('ver^|find "5.0."') do set OS=Windows NT&& set osrecognized=1
for /f %%i in ('ver^|find "5.1."') do set OS=Windows XP&& set osrecognized=1
for /f %%i in ('ver^|find "5.2."') do set OS=Windows 2003&& set osrecognized=1
for /f %%i in ('ver^|find "6.0."') do set OS=Windows Vista&& set osrecognized=1
for /f %%i in ('ver^|find "6.1."') do set OS=Windows 7&& set osrecognized=1
for /f %%i in ('ver^|find "6.2."') do set OS=Windows 8&& set osrecognized=1
for /f %%i in ('ver^|find "6.3."') do set OS=Windows 8.1&& set osrecognized=1
for /f %%i in ('ver^|find "10."')  do set OS=Windows 10&& set osrecognized=1

if not defined osrecognized goto OsNotSupported

echo. 
echo OS detected             = %os%
echo Processor arechitecture = %processor_architecture%
echo.
echo.
echo     #### Press any key to continue ####
pause > NUL

cls
echo **** Mediatek USB Driver Install v. %MTK_DRV_INST_VERSION%
echo.
echo. 

set PLATFORM=x86
if "%processor_architecture%"=="x86" (set PLATFORM=%cd%/SmartPhoneDriver/x86) ^
else (set PLATFORM=%cd%/SmartPhoneDriver/x64)

echo OS detected       = %os%
echo Platform detected = %processor_architecture%
echo Driver folder     = %PLATFORM%
echo.
echo.


echo **** Mediatek USB unsigned driver installation started...
"%PLATFORM%/dpinst.exe" /PATH "%PLATFORM%\Unsigned infs" /F /LM /SW /A
echo **** Mediatek USB unsigned driver installation completed!

echo.
echo **** Mediatek USB signed driver installation started...
"%PLATFORM%/dpinst.exe" /PATH "%PLATFORM%\Infs" /F /LM /SW /A
echo **** Mediatek USB signed driver installation completed!


goto end

:OsNotSupported
echo Do Not support Win NT earlier version

:end
echo.
echo.
echo     #### Press any key to exit ####
pause > NUL
echo.
echo.

SET MTK_DRV_INST_VERSION=1.00
SET OS=
set PLATFORM=
