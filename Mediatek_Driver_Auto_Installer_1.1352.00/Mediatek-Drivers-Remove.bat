@echo off
cls
SET MTK_DRV_INST_VERSION=1.00
echo **** Mediatek USB Driver Removal v. %MTK_DRV_INST_VERSION%    *

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
echo **** Mediatek USB Driver Removal v. %MTK_DRV_INST_VERSION%    *
echo. 
set PLATFORM=x86
if "%processor_architecture%"=="x86" (set PLATFORM=%cd%/SmartPhoneDriver/x86) ^
else (set PLATFORM=%cd%/SmartPhoneDriver/x64)

echo %PLATFORM%
echo.
echo.



echo **** Mediatek unsigned USB driver removal started...
"%PLATFORM%/DPInst.exe" /U "%PLATFORM%\Unsigned infs\android_winusb.inf" /SW /D
"%PLATFORM%/DPInst.exe" /U "%PLATFORM%\Unsigned infs\cdc-acm.inf" /SW /D
"%PLATFORM%/DPInst.exe" /U "%PLATFORM%\Unsigned infs\tetherxp.inf" /SW /D
"%PLATFORM%/DPInst.exe" /U "%PLATFORM%\Unsigned infs\wpdmtp.inf" /SW /D
echo **** Mediatek unsigned USB driver removal completed!
echo.


echo **** Mediatek signed USB driver removal started...
"%PLATFORM%/DPInst.exe" /U "%PLATFORM%\Infs\usbvcom.inf" /SW /D
"%PLATFORM%/DPInst.exe" /U "%PLATFORM%\Infs\usbvcom_brom.inf" /SW /D
echo **** Mediatek signed USB driver removal completed!

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

SET MTK_DRV_INST_VERSION=
SET OS=
SET PLATFORM=
