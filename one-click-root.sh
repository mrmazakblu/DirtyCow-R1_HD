#!/bin/sh

echo --------------------------------------------------------------------------------------------
echo THERE ARE 10 PAUSES IS THIS SCRIPT SO LOOK FOR PROMTS FOR YOU TO HIT ENTER
echo --------------------------------------------------------------------------------------------
echo [*] BEFORE WE BEGIN THE SCRIPT WILL RUN "ADB DEVICES" AND SEE IF YOU HAVE DRIVERS INSTLLED
echo [*] THE NEEDED RESPONSE IS SIMILAR TO BELOW 
echo [*] 
echo [*] List of devices attached
echo "[*] ****************        device"
echo [*] 
echo [*] INSTEAD OF STARS IT WILL BE YOUR SERIAL NUMBER 
echo [*] IF NO DEVICE LISTED YOU ARE NOT READY TO RUN THIS SCRIPT. CLOSE THIS WINDOW NOW IF NOT READY
echo [*] 
echo [*] IF DEVICE IS LISTED PRESS ANY KEY ON COMPUTER TO START
echo [*] 
adb wait-for-device
adb devices
echo -n "to continue press [enter]: "
read start
#clear
echo [*] copying dirtycow to /data/local/tmp/dirtycow
adb push pushed/dirtycow /data/local/tmp/dirtycow
sleep 2 > nul
echo [*] copying recowvery-app_process32 to /data/local/tmp/recowvery-app_process32
adb push pushed/recowvery-app_process32 /data/local/tmp/recowvery-app_process32
sleep 2 > nul
echo [*] copying frp.bin to /data/local/tmp/unlock
adb push pushed/frp.bin /data/local/tmp/unlock
sleep 2 > nul
echo [*] copying busybox to /data/local/tmp/busybox
adb push pushed/busybox /data/local/tmp/busybox
sleep 2 > nul
echo [*] copying cp_comands.txt to /data/local/tmp/cp_comands.txt
adb push pushed/cp_comands.txt /data/local/tmp/cp_comands.txt
sleep 2 > nul
echo [*] copying dd_comands.txt to /data/local/tmp/dd_comands.txt
adb push pushed/dd_comands.txt /data/local/tmp/dd_comands.txt
sleep 2 > nul
echo [*] changing permissions on copied files
adb shell chmod 0777 /data/local/tmp/*
sleep 2 > nul
#clear
echo --------------------------------------------------------------------------------------------
echo [*] DONE PUSHING FILES TO PHONE. NOW WE ARE GOING TO TEMP WRITE OVER THE APP_PROCESS
echo [*] WITH A MODIFIED VERSION THAT HAS lsh IN IT USING A SYSTEM-SERVER AS ROOT SHELL
echo [*] THIS STEP WILL CAUSE PHONE TO DO A SOFT REBOOT AND WILL NOT RESPOND TO BUTTON PUSHES
echo [*] 
adb shell /data/local/tmp/dirtycow /system/bin/app_process32 /data/local/tmp/recowvery-app_process32
echo --------------------------------------------------------------------------------------------
#clear
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*]WAITING 60 SECONDS FOR ROOT SHELL TO SPAWN
echo [*] WHILE APP_PROCESS IS REPLACED PHONE WILL APPEAR TO BE UNRESPONSIVE BUT SHELL IS WORKING
sleep 60 > nul
echo --------------------------------------------------------------------------------------------
echo [*] OPENING A ROOT SHELL ON THE NEWLY CREATED SYSTEM_SERVER
echo [*] MAKING A DIRECTORY ON PHONE TO COPY FRP PARTION TO 
echo [*] CHANGING PERMISSIONS ON NEW DIRECTORY
echo [*] COPYING FPR PARTION TO NEW DIRECTORY AS ROOT
echo [*] CHANGING PERMISSIONS ON COPIED FRP
adb shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/cp_comands.txt"
#clear
echo "[*] COPY UNLOCK.IMG OVER TOP OF COPIED FRP IN /data/local/test NOT AS ROOT WITH DIRTYCOW"
echo [*]
adb shell /data/local/tmp/dirtycow /data/local/test/frp /data/local/tmp/unlock
sleep 5 > nul
#clear
echo [*] WAITING 5 SECONDS BEFORE WRITING FRP TO EMMC
sleep 5 > nul
echo "[*] DD COPY THE NEW (UNLOCK.IMG) FROM /data/local/test/frp TO PARTITION mmcblk0p17"
adb shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/dd_comands.txt"
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo -----------REBOOTING_INTO_BOOTLOADER--------------------------------------------------------
adb reboot bootloader
#clear
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] YOUR PHONE SCREEN SHOULD BE BLACK WITH THE WORD "=>FASTBOOT mode..." IN LOWER CORNER
echo [*] JUST LIKE IN THE BEGINING WE NEED TO VERIFY YOU HAVE DRIVERS ON PC FOR THE NEXT STEP
echo [*] THE RESPONSE SHOULD BE 
echo [*]
echo "[*] ***************     fastboot"
echo [*]
echo [*] THE STARS WILL BE YOUR SERIAL NUMBER
echo [*] IF THE RESPONSE IS THIS THEN HIT ANY BUTTON ON PC TO CONTINUE
echo [*] 
echo [*] IF RESPONSE IS A BLANK LINE YOU DO NOT HAVE DRIVER NEEDED TO CONTINUE. CLOSE THIS WINDOW
echo [*] AND GET FASTBOOT DRIVERS THEN EITHER RUN "fastboot oem unlock" IN TERMINAL
fastboot devices
echo -n "to continue press [enter]: "
read start
#clear
echo [*] NOW THAT THE DEVICE IS IN FASTBOOT MODE WE ARE GOING TO UNLOCK THE
echo [*] BOOTLOADER. ON THE NEXT SCREEN ON YOUR PHONE YOU WILL SEE 
echo [*] PRESS THE VOLUME UP/DOWN BUTTONS TO SELECT YES OR NO
echo [*] JUST PRESS VOLUME UP TO START THE UNLOCK PROCESS.
echo --------------------------------------------------------------------------------------------
echo -------------------------------------------------------------------------------------------
echo [*] PRESS ENTER ON COMPUTER TO START THE UNLOCK
echo -n "to continue press [enter]: "
read start
fastboot oem unlock
#clear
echo [*] ONCE THE BOOTLOADER IS UNLOCKED PRESS ENTER TO WIPE DATA
echo -n "to continue press [enter]: "
read start
fastboot format userdata
#clear
echo [*] PRESS ENTER TO REBOOT THE DEVICE
echo -n "to continue press [enter]: "
read start
fastboot reboot
#clear
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] YOUR BOOTLOADER IS NOW UNLOCKED ON YOUR BLU R1 HD AMAZON DEVICE
echo [*] FIRST BOOT UP WILL TAKE AROUND 5 TO 10 MINUTES THEN YOU CAN SET IT UP 
echo [*] NEXT IS TO INSTALL RECOVERY TWRP
echo [*]
echo [*]
echo [*] YOU WILL NEED TO ENBLE DEVELOPERS OPTION, THEN ENABLE ADB TO CONTINUE NEXT SCRIPT 
echo "[*] ******************"
echo [*] IF PHONE DID NOT REBOOT HOLD POWER UNTILL IT POWERS OFF THEN AGAIN TO POWER ON
echo "[*] ******************"
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] PRESS ENTER TO INSTALL TWRP AFTER YOU ENABLE DEVELOPER OPTIONS ON PHONE
echo [*] OR CTRL+C TO STOP HERE
echo -n "to continue press [enter]: "
read start
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo -----------REBOOTING_INTO_BOOTLOADER--------------------------------------------------------
adb reboot bootloader
#clear
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] NOW YOUR IN FASTBOOT MODE AND READY TO FLASH TWRP RECOVERY
echo [*]  
echo [*] 
echo [*] 
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] PRESS ENTER TO FLASH RECOVERY
echo -n "to continue press [enter]: "
read start
fastboot flash recovery pushed/recovery.img
echo [*] ONCE THE FILE TRANSFER IS COMPLETE HOLD VOLUME UP AND PRESS ENTER ON PC 
echo [*]
echo [*] IF PHONE DOES NOT REBOOT THEN HOLD VOLUME UP AND POWER UNTILL IT DOES
echo -n "to continue press [enter]: "
read start
fastboot reboot
echo [*] ON PHONE SELECT RECOVERY FROM BOOT MENU WITH VOLUME KEY THEN SELECT WITH POWER
echo [*] PRESS ENTER ON PC FOR MORE NOTES
echo -n "to continue press [enter]: "
read start
#clear
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] NOW YOU BOOTED TO RECOVERY CONTINUE AND MAKE A BACKUP IF YOU WANT
echo [*]  YOU CAN JUST CONTINUE AS IS FROM HERE OR FLASH THE OLD PRELOADER FILE WITH 
echo [*] RECOVERY. THERE ARE MORE STEPS NOT INCLUDED HERE IF YOU WANT TO DO THAT.
echo [*]  
echo --------------------------------------------------------------------------------------------
echo --------------------------------------------------------------------------------------------
echo [*] PRESS ENTER TO FINISH THIS SCRIPT.
echo -n "to continue press [enter]: "
read start
exit
