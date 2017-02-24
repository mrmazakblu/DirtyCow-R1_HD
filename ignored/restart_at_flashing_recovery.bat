::Set our Window Title
@title R1 HD AMAZON Flash Recovery
mode 100,30
::Set our default parameters
@echo on
color 0b
echo.-----------REBOOTING_INTO_BOOTLOADER--------------------------------------------------------
adb reboot bootloader
timeout 15
fastboot flash recovery pushed/recovery.img
echo [*] ONCE THE FILE TRANSFER IS COMPLETE HOLD VOLUME UP ON PHONE AND PRESS ANY KEY ON PC 
echo [*]
pause
fastboot reboot
echo [*] IF PHONE DOES NOT REBOOT THEN HOLD VOLUME UP AND POWER UNTILL IT DOES
echo [*] Then
echo [*] ON PHONE SELECT RECOVERY FROM BOOT MENU WITH VOLUME KEY THEN SELECT WITH POWER
pause
exit