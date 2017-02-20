::Set our Window Title
@title R1 HD AMAZON BOOTLOADER UNLOCK
mode 100,30
::Set our default parameters
@echo off
color 0b
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] BEFORE WE BEGIN THE SCRIPT WILL RUN "ADB DEVICES" AND SEE IF YOU HAVE DRIVERS INSTLLED
echo [*] THE NEEDED RESPONSE IS SIMILAR TO BELOW 
echo [*]
echo [*] List of devices attached
echo [*] ****************        device
echo [*] 
echo [*] INSTEAD OF STARS IT WILL BE YOUR SERIAL NUMBER 
echo [*] IF NO DEVICE LISTED YOU ARE NOT READY TO RUN THIS SCRIPT. CLOSE THIS WINDOW NOW IF NOT READY
echo [*] 
echo [*] IF DEVICE IS LISTED PRESS ANY KEY ON COMPUTER TO START
echo [*]
adb devices
pause
adb wait-for-device
::cls
echo [*] copying dirtycow to /data/local/tmp/dirtycow
adb push pushed/dirtycow /data/local/tmp/dirtycow
timeout 10
echo [*] copying recowvery-app_process32 to /data/local/tmp/recowvery-app_process32
adb push pushed/recowvery-app_process32 /data/local/tmp/recowvery-app_process32
timeout 10
echo [*] copying frp.bin to /data/local/tmp/unlock
adb push pushed/frp.bin /data/local/tmp/unlock
timeout 10
echo [*] copying busybox to /data/local/tmp/busybox
adb push pushed/busybox /data/local/tmp/busybox
timeout 10
echo [*] copying cp_comands.txt to /data/local/tmp/cp_comands.txt
adb push pushed/cp_comands.txt /data/local/tmp/cp_comands.txt
timeout 10
echo [*] copying dd_comands.txt to /data/local/tmp/dd_comands.txt
adb push pushed/dd_comands.txt /data/local/tmp/dd_comands.txt
timeout 10
echo [*] changing permissions on copied files
adb shell chmod 0777 /data/local/tmp/*
timeout 10
::cls
echo.--------------------------------------------------------------------------------------------
echo [*] DONE PUSHING FILES TO PHONE. NOW WE ARE GOING TO TEMP WRITE OVER THE APP_PROCESS
echo [*] WITH A MODIFIED VERSION THAT HAS lsh IN IT USING A SYSTEM-SERVER AS ROOT SHELL
echo [*] THIS STEP WILL CAUSE PHONE TO DO A SOFT REBOOT AND WILL NOT RESPOND TO BUTTON PUSHES
echo [*] 
pause
adb shell /data/local/tmp/dirtycow /system/bin/app_process32 /data/local/tmp/recowvery-app_process32
echo.--------------------------------------------------------------------------------------------
::cls
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*]WAITING 60 SECONDS FOR ROOT SHELL TO SPAWN
echo [*] WHILE APP_PROCESS IS REPLACED PHONE WILL APPEAR TO BE UNRESPONSIVE BUT SHELL IS WORKING
timeout 60
echo.--------------------------------------------------------------------------------------------
echo [*] OPENING A ROOT SHELL ON THE NEWLY CREATED SYSTEM_SERVER
echo [*] MAKING A DIRECTORY ON PHONE TO COPY FRP PARTION TO 
echo [*] CHANGING PERMISSIONS ON NEW DIRECTORY
echo [*] COPYING FPR PARTION TO NEW DIRECTORY AS ROOT
echo [*] CHANGING PERMISSIONS ON COPIED FRP
adb shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/cp_comands.txt"
::cls
echo [*] COPYING UNLOCK.IMG OVER TOP OF COPIED FRP IN /data/local/test NOT AS ROOT WITH DIRTYCOW
echo [*]
adb shell /data/local/tmp/dirtycow /data/local/test/frp /data/local/tmp/unlock
timeout 5
::cls
pause
echo [*] WAITING 5 SECONDS BEFORE WRITING FRP TO EMMC
timeout 5
echo [*] DD COPY THE NEW (UNLOCK.IMG) FROM /data/local/test/frp TO PARTITION mmcblk0p17
adb shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/dd_comands.txt"
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo.-----------REBOOTING_INTO_BOOTLOADER--------------------------------------------------------
pause
adb reboot bootloader
::cls
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] YOUR PHONE SCREEN SHOULD BE BLACK WITH THE WORD "=>FASTBOOT mode..." IN LOWER CORNER
echo [*] JUST LIKE IN THE BEGINING WE NEED TO VERIFY YOU HAVE DRIVERS ON PC FOR THE NEXT STEP
echo [*] THE RESPONSE SHOULD BE 
echo [*]
echo [*] ***************     fastboot
echo [*]
echo [*] THE STARS WILL BE YOUR SERIAL NUMBER
echo [*] IF THE RESPONSE IS THIS THEN HIT ANY BUTTON ON PC TO CONTINUE
echo [*] 
echo [*] IF RESPONSE IS A BLANK LINE YOU DO NOT HAVE DRIVER NEEDED TO CONTINUE. CLOSE THIS WINDOW
echo [*] AND GET FASTBOOT DRIVERS THEN EITHER RUN "fastboot oem unlock" IN TERMINAL
fastboot devices
pause
::cls
echo [*] NOW THAT THE DEVICE IS IN FASTBOOT MODE WE ARE GOING TO UNLOCK THE
echo [*] BOOTLOADER. ON THE NEXT SCREEN ON YOUR PHONE YOU WILL SEE 
echo [*] PRESS THE VOLUME UP/DOWN BUTTONS TO SELECT YES OR NO
echo [*] JUST PRESS VOLUME UP TO START THE UNLOCK PROCESS.
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] PRESS ANY KEY ON COMPUTER TO START THE UNLOCK
pause
fastboot oem unlock
::cls
echo [*] ONCE THE BOOTLOADER IS UNLOCKED PRESS ANY KEY TO WIPE DATA
pause
fastboot format userdata
::cls
echo [*] PRESS ANY KEY TO REBOOT THE DEVICE
pause
fastboot reboot
::cls
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] YOUR BOOTLOADER IS NOW UNLOCKED ON YOUR BLU R1 HD AMAZON DEVICE
echo [*] FIRST BOOT UP WILL TAKE AROUND 5 TO 10 MINUTES THEN YOU CAN SET IT UP 
echo [*] NEXT IS TO INSTALL RECOVERY TWRP
echo [*]
echo [*]
echo [*] YOU WILL NEED TO ENBLE DEVELOPERS OPTION, THEN ENABLE ADB TO CONTINUE NEXT SCRIPT 
echo [*] ******************
echo [*] IF PHONE DID NOT REBOOT HOLD POWER UNTILL IT POWERS OFF THEN AGAIN TO POWER ON
echo [*] ******************
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] PRESS ANY KEY TO INSTALL TWRP AFTER YOU ENABLE DEVELOPER OPTIONS ON PHONE
echo [*] OR CTRL+C TO STOP HERE
pause
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo.-----------REBOOTING_INTO_BOOTLOADER--------------------------------------------------------
adb reboot bootloader
::cls
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] NOW YOUR IN FASTBOOT MODE AND READY TO FLASH TWRP RECOVERY
echo [*]  
echo [*] 
echo [*] 
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] PRESS ANY KEY TO FLASH RECOVERY
pause
fastboot flash recovery pushed/recovery.img
echo [*] ONCE THE FILE TRANSFER IS COMPLETE HOLD VOLUME UP AND PRESS ANY KEY ON PC 
echo [*]
echo [*] IF PHONE DOES NOT REBOOT THEN HOLD VOLUME UP AND POWER UNTILL IT DOES
pause
fastboot reboot
echo [*] ON PHONE SELECT RECOVERY FROM BOOT MENU WITH VOLUME KEY THEN SELECT WITH POWER
echo [*] PRESS ANY KEY ON PC FOR MORE NOTES
pause
::cls
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] NOW YOU BOOTED TO RECOVERY CONTINUE AND MAKE A BACKUP IF YOU WANT
echo [*]  YOU CAN JUST CONTINUE AS IS FROM HERE OR FLASH THE OLD PRELOADER FILE WITH 
echo [*] RECOVERY. THERE ARE MORE STEPS NOT INCLUDED HERE IF YOU WANT TO DO THAT.
echo [*]  
echo.--------------------------------------------------------------------------------------------
echo.--------------------------------------------------------------------------------------------
echo [*] PRESS ANY KEY TO FINISH THIS SCRIPT.
pause
exit
