#!/bin/bash
clear
chmod a+x R1-HD-TOOL2.sh

echo   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echo   "     ____  _       _   _ ____     _____ ___   ___  _        ____          "
echo   "    |  _ \/ |     | | | |  _ \   |_   _/ _ \ / _ \| |      |___  \        "
echo   "    | |_) | |_____| |_| | | | |    |'|| | | | | | | |        __) |        "
echo   "    |  _ <| |_____|  _  | |_| |    | || |_| | |_| | |___    / __/         "
echo   "    |_| \_\_|     |_| |_|____/     |_| \___/ \___/|_____|  |_____|        "
echo   "                                                                          "
echo   "                                                                          "
echo   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echo "----------------------------------------------------------------------------"
PS3='Please enter your choice number: '
options=("Flash SuperSu 1" "AMZ Full Debloat script v2 2" "AMZ Part Debloat script v2 3" "Google Debloat v2 4" "MTK_BLU Debloat v2 5" "UNDO DE-BLOAT 6" "Add FM Radio 7" "ROLL Back Preloader 8" "Return to Main 9")
select opt in "${options[@]}"
	do
		case $opt in
			"Flash SuperSu 1")
				adb reboot recovery
				adb wait-for-device
				adb push pushed/UPDATE-SuperSU-v2.76-20160630161323.zip /sdcard/Download
				adb shell "/sbin;recovery -- update_package=/sdcard/Download/UPDATE-SuperSU-v2.76-20160630161323.zip"
				sudo $ADB kill-server
				echo "press enter to exit"
					read \n
				bash R1-HD-TOOL.sh
				exit
			;;
			"AMZ Full Debloat script v2 2")
				adb reboot recovery
				adb wait-for-device
				adb push pushed/bluR1-AMZ-FULLdebloat-blockOTA_v2.zip /sdcard/Download
				adb shell "/sbin;recovery -- update_package=/sdcard/Download/bluR1-AMZ-FULLdebloat-blockOTA_v2.zip"
				echo debloat scripts curtesy of emc2cube
				sudo $ADB kill-server
				bash R1-HD-TOOL.sh
				exit 
			;;
			"AMZ Part Debloat script v2 3")
				adb reboot recovery
				adb wait-for-device
				adb push pushed/bluR1-AMZ-PARTIALdebloat-blockOTA_v2.zip /sdcard/Download
				adb shell "/sbin;recovery -- update_package=/sdcard/Download/bluR1-AMZ-PARTIALdebloat-blockOTA_v2.zip"
				echo debloat scripts curtesy of emc2cube
				sudo $ADB kill-server
				bash R1-HD-TOOL.sh
				exit
			;;
			"Google Debloat v2 4")
				adb reboot recovery
				adb wait-for-device
				adb push pushed/bluR1-GOOGLE-debloat_v2.zip /sdcard/Download
				adb shell "/sbin;recovery -- update_package=/sdcard/Download/bluR1-GOOGLE-debloat_v2.zip"
				echo debloat scripts curtesy of emc2cube
				sudo $ADB kill-server
				bash R1-HD-TOOL.sh
				exit
			;;
			"MTK_BLU Debloat v2 5")
				adb reboot recovery
				adb wait-for-device
				adb push pushed/bluR1-MTK_BLU-debloat_v2.zip /sdcard/Download
				adb shell "/sbin;recovery -- update_package=/sdcard/Download/bluR1-MTK_BLU-debloat_v2.zip"
				echo debloat scripts curtesy of emc2cube
				bash R1-HD-TOOL1.sh
				exit
			;;
			"UNDO DE-BLOAT 6")
				adb reboot recovery
				adb wait-for-device
				adb push pushed/bluR1-RestoreApps-OTA.zip /sdcard/Download
				adb shell "/sbin;recovery -- update_package=/sdcard/Download/bluR1-RestoreApps-OTA.zip"
				echo debloat scripts curtesy of emc2cube
				bash R1-HD-TOOL.sh
				exit
				;;
			"Add FM Radio 7")
				adb reboot recovery
				adb wait-for-device
				adb push pushed/fm_Radio_WITHOUT_boot.zip /sdcard/Download
				adb shell "sbin;recovery -- update_package=/sdcard/Download/fm_Radio_WITHOUT_boot.zip"
				echo Also need to install A program called selinux mode changer
				echo It is available from Either xda thread
				echo https://forum.xda-developers.com/devdb/project/dl/?id=12506
				echo  or also from F-Droid
				echo "[*] press enter to continue"
					read \n
				bash R1-HD-TOOL.sh
				exit
			;;
			"ROLL Back Preloader 8")
				echo It is likely that at past this point phone is Boot-looping 
				echo At this point if looping Hold volume up during the boot-looping
				echo you should be at the boot select menu now
				echo Use volume keys to choose fastboot, then power button to enter
				echo BOOTLOADER WILL NOW BE MADE "SECURE = NO" BY REDOING OEM UNLOCK
				echo "[*] press enter to continue"
					read \n
				adb reboot recovery
				adb wait-for-device
				adb push pushed/after_bootloader_roll_back_5.zip /sdcard/Download
				adb shell "/sbin;recovery -- update_package=/sdcard/Download/after_bootloader_roll_back_5.zip"
				echo WAIT FOR FASTBOOT MODE THEN PRESS ENTER
				sleep 30
				echo "[*] press enter to continue"
					read \n
				fastboot getvar all 2> "working/getvar.txt"
				if grep -q "secure: no" "working/getvar.txt"; then
					echo "Already Fully Unlocked Going Back to Menu"
					echo "press enter to exit"
					read \n
					fastboot reboot
					bash R1-HD-TOOL.sh
					exit
				else
					echo "Not Fully Unlocked Yet"
					echo "[*] ON YOUR PHONE YOU WILL SEE"
					echo "[*] PRESS THE VOLUME UP/DOWN BUTTONS TO SELECT YES OR NO"
					echo "[*] JUST PRESS VOLUME UP TO START THE UNLOCK PROCESS."
					echo "-------------------------------------------------------------------------"
					echo "-------------------------------------------------------------------------"
					echo "[*] press enter to continue"
						read \n
					fastboot oem unlock
					sleep 5
					fastboot format userdata
					sleep 5
					fastboot format cache
					sleep 5
					fastboot reboot
					echo "[*]         IF PHONE DID NOT REBOOT ON ITS OWN" 
					echo "[*]         HOLD POWER BUTTON UNTILL IT TURNS OFF"
					echo "[*]         THEN TURN IT BACK ON"
					echo "[*]         EITHER WAY YOU Might SEE ANDROID ON HIS BACK" 
					echo "[*]         WHEN PHONE BOOTS, FOLLOWED BY STOCK RECOVERY"
					echo "[*]         DOING A FACTORY RESET"
					echo "[*] press enter to exit"
						read \n
					sudo $ADB kill-server
					bash R1-HD-TOOL.sh
					exit
				fi
			;;
			"Return to Main 9")
				bash R1-HD-TOOL.sh
				exit
			;;
			*) echo invalid option;;
		esac
	done
