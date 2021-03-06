#!/bin/bash
clear
chmod a+x R1-HD-TOOL.sh
adddate() {
    while IFS= read -r line; do
        echo "$(date) $line"
    done
}
adb_check() {
$ADB devices -l > working/adb_devices.txt
sleep 5
if grep -q "product:" "working/adb_devices.txt"; then
	echo adb device found
	return
else
	echo no detected devices
	echo "No Adb devices found " | adddate  >> "log.txt"
	echo "trying to return from fastboot"
	fast_check
	$FASTBOOT reboot
	echo "sleeping some time to allow for reboot time"
	sleep 30
	adb_check
	return
fi
}
fast_check() {
$ADB devices -l > working/adb_devices.txt
sleep 5
if grep -q "product:" "working/adb_devices.txt"; then
	echo adb device found
	$ADB reboot bootloader
	echo sleeping 10 seconds
	sleep 20
fi
$FASTBOOT devices -l > working/fast_devices.txt
sleep 5
if grep -q "fastboot" "working/fast_devices.txt"; then
	echo fastboot detected
	return
else
	echo "No Fastboot devices found " | adddate  >> "log.txt"
	echo "No Fastboot devices found "
	echo "press enter to exit"
	read \n
	bash R1-HD-TOOL.sh
	exit
fi
}
function platform
{       platform=`uname`
        if [ $(uname -p) = 'powerpc' ]; then
        echo "[-] PowerPC is not supported."
        exit 1
        fi
 
        if [ "$platform" = 'Darwin' ]; then
        ADB="files/./adbosx"
        FASTBOOT="files/./fastbootosx"
        version="OS X"
        else
        ADB="files/./adblinux"
        FASTBOOT="files/./fastbootlinux"
        version="Linux"
               
        fi
}

platform
echo   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echo   "          ____  _       _   _ ____     _____ ___   ___  _                 "
echo   "         |  _ \/ |     | | | |  _ \   |_   _/ _ \ / _ \| |                "
echo   "         | |_) | |_____| |_| | | | |    |'|| | | | | | | |                "
echo   "         |  _ <| |_____|  _  | |_| |    | || |_| | |_| | |___             "
echo   "         |_| \_\_|     |_| |_|____/     |_| \___/ \___/|_____|            "
echo   "                                                                          "
echo   "                                                                          "
echo   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echo "----------------------------------------------------------------------------"
PS3='Please enter your choice number: '
options=("Push Files for Dirtycow 1" "Run the Dirty-cow Part 2" "Do Bootloader Unlock 3" "Flash TWRP 4" "Extra Menu 5" "SEE INSTRUCTIONS 6" "EXIT 7" "VIEW LOG 8" "CLEAR LOG 9")
select opt in "${options[@]}"
	do
		case $opt in
			"Push Files for Dirtycow 1")
				adb_check
				echo "-----Copying files To Phone needed to do do the dirty-cow-----------------------"
				echo "--------------------------------------------------------------------------------"
				echo "press enter to continue"
						read \n
				echo [*] clear tmp folder
				$ADB shell rm -f /data/local/tmp/*
				echo [*] copying dirtycow to /data/local/tmp/dirtycow
				$ADB push pushed/dirtycow /data/local/tmp/dirtycow
				sleep 3
				echo [*] copying recowvery-app_process32 to /data/local/tmp/recowvery-app_process32
				$ADB push pushed/recowvery-app_process32 /data/local/tmp/recowvery-app_process32
				sleep 3
				echo [*] copying frp.bin to /data/local/tmp/unlock
				$ADB push pushed/frp.bin /data/local/tmp/unlock
				sleep 3
				echo [*] copying busybox to /data/local/tmp/busybox
				$ADB push pushed/busybox /data/local/tmp/busybox
				sleep 3
				echo [*] copying cp_comands.txt to /data/local/tmp/cp_comands.txt
				$ADB push pushed/cp_comands.txt /data/local/tmp/cp_comands.txt
				sleep 3
				echo [*] copying dd_comands.txt to /data/local/tmp/dd_comands.txt
				$ADB push pushed/dd_comands.txt /data/local/tmp/dd_comands.txt
				sleep 3
				echo [*] changing permissions on copied files
				$ADB shell chmod 0777 /data/local/tmp/*
				sleep 3
				echo [*] checking contents of phone folder
				$ADB shell ls -l /data/local/tmp > "working/phone_file_check.txt" 
				$ADB shell /data/local/tmp/busybox md5sum /data/local/tmp/unlock > "working/phone_file_md5.txt"
				$ADB shell /data/local/tmp/busybox md5sum /data/local/tmp/recowvery-app_process32 >> "working/phone_file_md5.txt"
				$ADB shell /data/local/tmp/busybox md5sum /data/local/tmp/dirtycow >> "working/phone_file_md5.txt"
				$ADB shell /data/local/tmp/busybox md5sum /data/local/tmp/dd_comands.txt >> "working/phone_file_md5.txt"
				$ADB shell /data/local/tmp/busybox md5sum /data/local/tmp/cp_comands.txt >> "working/phone_file_md5.txt"
				$ADB shell /data/local/tmp/busybox md5sum /data/local/tmp/busybox >> "working/phone_file_md5.txt"
				sleep 5
				if grep -q "b5eec83df6dd57902a857f6c542e793e  /data/local/tmp/busybox" "working/phone_file_md5.txt"; then
					echo busybox matches md5
				else
					echo busybox file doesnot match 
					echo need to push files again maybe need to download zip file again too
					echo "[W] busybox File pushed to phone do not match md5" | adddate >> "log.txt"
					echo "press enter to exit"
						read \n
					bash R1-HD-TOOL.sh
						exit
				fi	
				if grep -q "df5cf88006478ad421028c58df5a55ad  /data/local/tmp/cp_comands.txt" "working/phone_file_md5.txt"; then
					echo cp_comands.txt matches md5
				else
					echo cp_comands.txt file does not match 
					echo need to push files again maybe need to download zip file again too
					echo "[W] cp_comands.txt File pushed to phone do not match md5" | adddate  >> "log.txt"
					echo "press enter to exit"
						read \n
					bash R1-HD-TOOL.sh
						exit
				fi	
				if grep -q "28443a967a9b39215b5102573ef1731b  /data/local/tmp/dd_comands.txt" "working/phone_file_md5.txt"; then
					echo dd_comands.txt matches md5
				else
					echo dd_comands.txt file does not match 
					echo need to push files again maybe need to download zip file again too
					echo "[W] dd_comands.txt File pushed to phone do not match md5" | adddate >> "log.txt"
					echo "press enter to exit"
						read \n
					bash R1-HD-TOOL.sh
						exit
				fi	
				if grep -q "8259b595dbfa9cea131bd798ad4ef323  /data/local/tmp/dirtycow" "working/phone_file_md5.txt"; then
					echo dirtycow matches md5
				else
					echo dirtycow file does not match 
					echo need to push files again maybe need to download zip file again too
					echo "[W] dirtycow Files pushed to phone do not match md5" | adddate  >> "log.txt"
					echo "press enter to exit"
						read \n
					bash R1-HD-TOOL.sh
						exit
				fi	
				if grep -q "d201fb59330cc11343452479757f6c40  /data/local/tmp/recowvery-app_process32" "working/phone_file_md5.txt"; then
					echo recowvery-app_process32 matches md5
				else
					echo recowvery-app_process32 file does not match 
					echo need to push files again maybe need to download zip file again too
					echo "[W] recowvery-app_process32 pushed to phone do not match md5" | adddate  >> "log.txt"
					echo "press enter to exit"
						read \n
					bash R1-HD-TOOL.sh
						exit
				fi	
				if grep -q "18ab1955384691a35b127a3eebd6ef72  /data/local/tmp/unlock" "working/phone_file_md5.txt"; then
					echo unlock matches md5
				else
					echo unlock file does not match 
					echo need to push files again maybe need to download zip file again too 
					echo "[W] unlock File pushed to phone do not match md5" | adddate  >> "log.txt"
					echo "press enter to exit"
						read \n
					bash R1-HD-TOOL.sh
						exit
				fi	
					echo       File compair matches
					echo       Safe to continue to run Dirty-cow
				sudo $ADB kill-server
				echo "press enter to exit"
					read \n
				bash R1-HD-TOOL.sh
				exit
			;;
			"Run the Dirty-cow Part 2")
				adb_check
				echo "--------------------------------------------------------------------------------"
				$ADB shell /data/local/tmp/dirtycow /system/bin/app_process32 /data/local/tmp/recowvery-app_process32
				echo --------------------------------------------------------------------------------------------
				echo "Dirty-cow started" | adddate >> log.txt
				echo --------------------------------------------------------------------------------------------
				echo --------------------------------------------------------------------------------------------
				echo [*]WAITING 60 SECONDS FOR ROOT SHELL TO SPAWN
				echo [*] WHILE APP_PROCESS IS REPLACED PHONE WILL APPEAR TO BE UNRESPONSIVE BUT SHELL IS WORKING
				sleep 60
				# pause
				echo --------------------------------------------------------------------------------------------
				echo [*] OPENING A ROOT SHELL ON THE NEWLY CREATED SYSTEM_SERVER
				echo [*] MAKING A DIRECTORY ON PHONE TO COPY FRP PARTION TO 
				echo [*] CHANGING PERMISSIONS ON NEW DIRECTORY
				echo [*] COPYING FRP PARTION TO NEW DIRECTORY AS ROOT
				echo [*] CHANGING PERMISSIONS ON COPIED FRP
				$ADB shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/cp_comands.txt"
				echo [*] COPYING UNLOCK.IMG OVER TOP OF COPIED FRP IN /data/local/test NOT AS ROOT WITH DIRTYCOW
				echo [*]
				$ADB shell /data/local/tmp/dirtycow /data/local/test/frp /data/local/tmp/unlock
				sleep 5
				echo checking md5 of new frp before copying to mmcblk0p17
				$ADB shell /data/local/tmp/busybox md5sum /data/local/test/frp > "working/new_frp_md5.txt"
				if grep -q "18ab1955384691a35b127a3eebd6ef72  /data/local/test/frp" "working/new_frp_md5.txt"; then
					echo new FRP matches md5
				else
					echo unlock file does not match 
					echo Something Went Wrong Restarting phone and try again 
					echo "[W] New FRP final stage in dirty-cow does not match md5" | adddate >> "log.txt"
					echo "press enter to exit"
					read \n
					$ADB reboot
					bash R1-HD-TOOL.sh
					exit
				fi
				echo "[*] WAITING 5 SECONDS BEFORE WRITING FRP TO EMMC"
				sleep 5
				echo "[*] DD COPY THE NEW (UNLOCK.IMG) FROM /data/local/test/frp TO PARTITION mmcblk0p17"
				$ADB shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/dd_comands.txt"
				echo "coping new frp is done phone will now reboot and script will return to start screen"
				echo "press enter to exit"
					read \n
				$ADB reboot
				sudo $ADB kill-server
				bash R1-HD-TOOL.sh
				exit 
			;;
			"Do Bootloader Unlock 3")
				echo "--------------------------------------------------------------------------------"
				fast_check
				$FASTBOOT getvar all 2> "working/getvar.txt"
				if grep -q "unlocked: yes" "working/getvar.txt"; then
					echo "Already Unlocked Going Back to Menu"
					echo "press enter to exit"
					read \n
					$FASTBOOT reboot
					bash R1-HD-TOOL.sh
					exit
				else
					echo "Not Unlocked Yet"
				fi
				$FASTBOOT flashing get_unlock_ability 2> "working/unlockability.txt"
				sed -i '3,4d' working/unlockability.txt
				sed -i '1d' working/unlockability.txt
				sed -i 's/[^0-9]//g' working/unlockability.txt
				value=$(cat working/unlockability.txt)
				if [ "$value" -gt "99" ]; then 
				    echo "Unlockability shows phone is unlockable"
					echo "continueing"
				else
					echo "phone shows that it is not unlockable yet"
					echo "press enter to exit"
					echo "Phone Failed unlockability check"  | adddate >> log.txt
					read \n
					$FASTBOOT reboot
					bash R1-HD-TOOL.sh
					exit
				fi
				echo "[*] ON YOUR PHONE YOU WILL SEE"
				echo "[*] PRESS THE VOLUME UP/DOWN BUTTONS TO SELECT YES OR NO"
				echo "[*] JUST PRESS VOLUME UP TO START THE UNLOCK PROCESS."
				echo "-------------------------------------------------------------------------"
				echo "-------------------------------------------------------------------------"
				echo "[*] press enter to continue"
					read \n
				$FASTBOOT oem unlock
				sleep 5
				$FASTBOOT format userdata
				sleep 5
				$FASTBOOT format cache
				sleep 5
				$FASTBOOT reboot
				echo "OEM UNLOCK HAS BEEN RUN and userdata formated" | adddate >> log.txt
				echo "[*]         IF PHONE DID NOT REBOOT ON ITS OWN" 
				echo "[*]         HOLD POWER BUTTON UNTILL IT TURNS OFF"
				echo "[*]         THEN TURN IT BACK ON"
				echo "[*]         EITHER WAY YOU SHOULD SEE ANDROID ON HIS BACK" 
				echo "[*]         WHEN PHONE BOOTS, FOLLOWED BY STOCK RECOVERY"
				echo "[*]         DOING A FACTORY RESET"
				echo "[*] press enter to exit"
					read \n
				bash R1-HD-TOOL.sh
				exit
			;;
			"Flash TWRP 4")
				fast_check
				$FASTBOOT getvar all 2> "working/getvar.txt"
				if grep -q "unlocked: yes" "working/getvar.txt"; then
					echo "Already Unlocked Going to continue"
				else
					echo "Not Unlocked Yet"
					echo "press enter to exit"
					echo "Recovery attempted to install when bootloader shows locked" | adddate >> log.txt
					echo read \n
					$FASTBOOT reboot
					bash R1-HD-TOOL.sh
					exit
				fi
					echo "continue to TWRP option, you are alread unlocked"
					echo "[*] DEFAULT CHOISE OF RECOVERY HAS BEEN SET TO VAMPIREFO-S 7.1"
					PS3='Please enter your choice number: '
					options=("vampirefo 1" "lopestom 2")
						select opt in "${options[@]}"
							do
								case $opt in
									"vampirefo 1")
										echo "--------------------------------------------------------------------------------"
										echo "you chose to instal Vampirefo-s V7.1 built recovery" 
										echo "[I] Vamirefo-s v7.1 TWRP Recovery flashed" | adddate >> log.txt
										$FASTBOOT flash recovery pushed/twrp_p6601_7.1_recovery.img
										echo "[*] ONCE THE FILE TRANSFER IS COMPLETE HOLD VOLUME UP AND PRESS ANY KEY ON PC" 
										echo "[*]"
										echo "[*] IF PHONE DOES NOT REBOOT THEN HOLD VOLUME UP AND POWER UNTILL IT DOES"
										echo "[*] ON PHONE SELECT RECOVERY FROM BOOT MENU WITH VOLUME KEY THEN SELECT WITH POWER"
										echo "[*] press enter to continue"
										read \n
										$FASTBOOT reboot
										bash R1-HD-TOOL.sh
										exit
									;;
									"lopestom 2")
										echo "--------------------------------------------------------------------------------"
										echo "you chose to instal Lopestom original ported twrp"
										echo "[I] Lopestom TWRP Recovery flashed" | adddate >> log.txt
										$FASTBOOT flash recovery pushed/recovery.img
										echo "[*] ONCE THE FILE TRANSFER IS COMPLETE HOLD VOLUME UP AND PRESS ANY KEY ON PC" 
										echo "[*] IF PHONE DOES NOT REBOOT THEN HOLD VOLUME UP AND POWER UNTILL IT DOES"
										echo "[*] ON PHONE SELECT RECOVERY FROM BOOT MENU WITH VOLUME KEY THEN SELECT WITH POWER"
										echo "[*] press enter to continue"
										read \n
										$FASTBOOT reboot
										bash R1-HD-TOOL.sh
										exit
									;;
									*) echo invalid option
									;;
								esac
							done	
				bash R1-HD-TOOL.sh
				exit
			;;
			"Extra Menu 5")
				echo "--------------------------------------------------------------------------------"
				echo "[*] press enter to continue"
					read \n
				bash R1-HD-TOOL2.sh
				exit
			;;
			"SEE INSTRUCTIONS 6")
				echo "--Instructions Have not been written yet----------------------------"
				bash R1-HD-TOOL.sh
				exit
				;;
			"EXIT 7")
				rm -f working/*.txt
				exit
			;;
			"VIEW LOG 8")
				clear
				cat log.txt
				echo "[*] press enter to continue"
					read \n
				bash R1-HD-TOOL.sh
				exit
			;;
			"CLEAR LOG 9")
				rm -f log.txt
				echo "[*] press enter to confirm Delete logs and continue"
				echo "close window to cancel delete logs"
					read \n
				bash R1-HD-TOOL.sh
				exit
			;;
			*) echo invalid option;;
		esac
	done
