#!/bin/bash
clear
# Bash Menu Script Example
# chmod +x files/adblinux
# chmod +x files/fastbootlinux
chmod a+x R1-HD-TOOL.sh
function foo { echo start function; ( echo start subshell; return; echo end subshell); echo end function; }

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
    		echo "-----Copying files To Phone needed to do do the dirty-cow-----------------------"
			echo "--------------------------------------------------------------------------------"
			echo "press enter to continue"
    		    	read \n
			echo [*] clear tmp folder
			adb shell rm -f /data/local/tmp/*
			echo [*] copying dirtycow to /data/local/tmp/dirtycow
			adb push pushed/dirtycow /data/local/tmp/dirtycow
			sleep 3
			echo [*] copying recowvery-app_process32 to /data/local/tmp/recowvery-app_process32
			adb push pushed/recowvery-app_process32 /data/local/tmp/recowvery-app_process32
			sleep 3
			echo [*] copying frp.bin to /data/local/tmp/unlock
			adb push pushed/frp.bin /data/local/tmp/unlock
			sleep 3
			echo [*] copying busybox to /data/local/tmp/busybox
			adb push pushed/busybox /data/local/tmp/busybox
			sleep 3
			echo [*] copying cp_comands.txt to /data/local/tmp/cp_comands.txt
			adb push pushed/cp_comands.txt /data/local/tmp/cp_comands.txt
			sleep 3
			echo [*] copying dd_comands.txt to /data/local/tmp/dd_comands.txt
			adb push pushed/dd_comands.txt /data/local/tmp/dd_comands.txt
			sleep 3
			echo [*] changing permissions on copied files
			adb shell chmod 0777 /data/local/tmp/*
			sleep 3
			echo [*] checking contents of phone folder
			adb shell ls -l /data/local/tmp > "working/phone_file_check.txt" 
			adb shell /data/local/tmp/busybox md5sum /data/local/tmp/unlock > "working/phone_file_md5.txt"
			adb shell /data/local/tmp/busybox md5sum /data/local/tmp/recowvery-app_process32 >> "working/phone_file_md5.txt"
			adb shell /data/local/tmp/busybox md5sum /data/local/tmp/dirtycow >> "working/phone_file_md5.txt"
			adb shell /data/local/tmp/busybox md5sum /data/local/tmp/dd_comands.txt >> "working/phone_file_md5.txt"
			adb shell /data/local/tmp/busybox md5sum /data/local/tmp/cp_comands.txt >> "working/phone_file_md5.txt"
			adb shell /data/local/tmp/busybox md5sum /data/local/tmp/busybox >> "working/phone_file_md5.txt"
			sleep 5
			if grep -q "b5eec83df6dd57902a857f6c542e793e  /data/local/tmp/busybox" "working/phone_file_md5.txt"; then
				echo busybox matches md5
			else
				echo busybox file doesnot match 
				echo need to push files again maybe need to download zip file again too && echo %date% %time% [W] busybox File pushed to phone do not match md5. >> "log.txt"
				echo "press enter to exit"
					read \n
				bash R1-HD-TOOL.sh
					exit
			fi	
			if grep -q "df5cf88006478ad421028c58df5a55ad  /data/local/tmp/cp_comands.txt" "working/phone_file_md5.txt"; then
				echo cp_comands.txt matches md5
			else
				echo cp_comands.txt file does not match 
				echo need to push files again maybe need to download zip file again too && echo %date% %time% [W] cp_comands.txt File pushed to phone do not match md5. >> "log.txt"
				echo "press enter to exit"
					read \n
				bash R1-HD-TOOL.sh
					exit
			fi	
			if grep -q "28443a967a9b39215b5102573ef1731b  /data/local/tmp/dd_comands.txt" "working/phone_file_md5.txt"; then
				echo dd_comands.txt matches md5
			else
				echo dd_comands.txt file does not match 
				echo need to push files again maybe need to download zip file again too && echo %date% %time% [W] dd_comands.txt File pushed to phone do not match md5. >> "log.txt"
				echo "press enter to exit"
					read \n
				bash R1-HD-TOOL.sh
					exit
			fi	
			if grep -q "8259b595dbfa9cea131bd798ad4ef323  /data/local/tmp/dirtycow" "working/phone_file_md5.txt"; then
				echo dirtycow matches md5
			else
				echo dirtycow file does not match 
				echo need to push files again maybe need to download zip file again too && echo %date% %time% [W] dirtycow Files pushed to phone do not match md5. >> "log.txt"
				echo "press enter to exit"
					read \n
				bash R1-HD-TOOL.sh
					exit
			fi	
			if grep -q "d201fb59330cc11343452479757f6c40  /data/local/tmp/recowvery-app_process32" "working/phone_file_md5.txt"; then
				echo recowvery-app_process32 matches md5
			else
				echo recowvery-app_process32 file does not match 
				echo need to push files again maybe need to download zip file again too && echo %date% %time% [W] recowvery-app_process32 pushed to phone do not match md5. >> "log.txt"
				echo "press enter to exit"
					read \n
				bash R1-HD-TOOL.sh
					exit
			fi	
			if grep -q "18ab1955384691a35b127a3eebd6ef72  /data/local/tmp/unlock" "working/phone_file_md5.txt"; then
				echo unlock matches md5
			else
				echo unlock file does not match 
				echo need to push files again maybe need to download zip file again too && echo %date% %time% [W] unlock File pushed to phone do not match md5. >> "log.txt"
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
        	echo "--------------------------------------------------------------------------------"
			adb shell /data/local/tmp/dirtycow /system/bin/app_process32 /data/local/tmp/recowvery-app_process32
			echo --------------------------------------------------------------------------------------------
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
			adb shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/cp_comands.txt"
			echo [*] COPYING UNLOCK.IMG OVER TOP OF COPIED FRP IN /data/local/test NOT AS ROOT WITH DIRTYCOW
			echo [*]
			adb shell /data/local/tmp/dirtycow /data/local/test/frp /data/local/tmp/unlock
			sleep 5
			echo checking md5 of new frp before copying to mmcblk0p17
			adb shell /data/local/tmp/busybox md5sum /data/local/test/frp > "working/new_frp_md5.txt"
			if grep -q "18ab1955384691a35b127a3eebd6ef72  /data/local/test/frp" "working/new_frp_md5.txt"; then
				echo new FRP matches md5
			else
				echo unlock file does not match 
				echo Something Went Wrong Restarting phone and try again && echo %date% %time% [W] New FRP final stage in dirty-cow does not match md5. >> "log.txt"
				echo "press enter to exit"
				read \n
				adb reboot
				bash R1-HD-TOOL.sh
				exit
			fi
			echo [*] WAITING 5 SECONDS BEFORE WRITING FRP TO EMMC
			sleep 5
			echo [*] DD COPY THE NEW (UNLOCK.IMG) FROM /data/local/test/frp TO PARTITION mmcblk0p17
			adb shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/dd_comands.txt"
			echo coping new frp is done phone will now reboot and script will return to start screen
			echo "press enter to exit"
                read \n
            adb reboot
			sudo $ADB kill-server
            bash R1-HD-TOOL.sh
            exit 
            ;;
        "Do Bootloader Unlock 3")
            echo "--------------------------------------------------------------------------------"
			adb reboot bootloader
			fastboot getvar all 2> "working/getvar.txt"
			if grep -q "unlocked: yes" "working/getvar.txt"; then
				echo Already Unlocked Going Back to Menu
				echo "press enter to exit"
				read \n
				adb reboot
				bash R1-HD-TOOL.sh
				exit
			else
				echo Not Unlocked Yet
			fi
			fastboot flashing get_unlock_ability 2> "working/unlockability.txt"
			if grep -q "^(bootloader) unlock_ability" "working/unlockability.txt"; then
				# "number=$(grep "unlock-ability =" "working/unlockability.txt" | sed s'/unlock-abulity\ =\ //g')"
				echo Unlockability shows phone is unlockable
				echo This function is not working correct yet it is set to allways pass
			else
				echo Not Unlockable Yet Rebooting now and try again
				echo "press enter to exit"
				echo This function is not working correct yet it is set to allways pass
				#read \n
				#adb reboot
				#bash R1-HD-TOOL.sh
				#exit
			fi
#			for /f "tokens=4" %%i in ('findstr "^(bootloader) unlock_ability" %~dp0\working\unlockability.txt') do set unlock=%%i
#			echo output from find string = %unlock%
#			if %unlock% gtr 1 ( 
#			echo unlockable
#			GOTO Continue
#			) else (
#			echo Not-unlockable
#			echo must re-run dirty-cow && echo %date% %time% [W] Checking Unlock_ability failed. >> "dirty-cow-log/log.txt"
			echo [*] ON YOUR PHONE YOU WILL SEE 
			echo [*] PRESS THE VOLUME UP/DOWN BUTTONS TO SELECT YES OR NO
			echo [*] JUST PRESS VOLUME UP TO START THE UNLOCK PROCESS.
			echo.-------------------------------------------------------------------------
			echo.-------------------------------------------------------------------------
			echo "[*] press enter to continue"
                read \n
			fastboot oem unlock
			sleep 5
			fastboot format userdata
			sleep 5
			fastboot format cache
			sleep 5
			fastboot reboot
			echo [*]         IF PHONE DID NOT REBOOT ON ITS OWN 
			echo [*]         HOLD POWER BUTTON UNTILL IT TURNS OFF
			echo [*]         THEN TURN IT BACK ON
			echo [*]         EITHER WAY YOU SHOULD SEE ANDROID ON HIS BACK 
			echo [*]         WHEN PHONE BOOTS, FOLLOWED BY STOCK RECOVERY 
			echo [*]         DOING A FACTORY RESET
			echo "[*] press enter to exit"
                read \n
            sudo $ADB kill-server
            bash R1-HD-TOOL.sh
            exit
            ;;
        "Flash TWRP 4")
            adb reboot bootloader
			fastboot getvar all 2> "working/getvar.txt"
			if grep -q "unlocked: yes" "working/getvar.txt"; then
				echo Already Unlocked Going to continue
			else
				echo Not Unlocked Yet
				echo "press enter to exit"
				read \n
				adb reboot
				bash R1-HD-TOOL.sh
				exit
			fi
				echo continue to TWRP option, you are alread unlocked
			echo [*] DEFAULT CHOISE OF RECOVERY HAS BEEN SET TO VAMPIREFO-S 7.1
			PS3='Please enter your choice number: '
			options=("vampirefo 1" "lopestom 2")
			select opt in "${options[@]}"
				do
				case $opt in
				"vampirefo 1")
					echo "--------------------------------------------------------------------------------"
					echo you chose to instal Vampirefo-s V7.1 built recovery && echo %date% %time% [I] Vamirefo-s v7.1 TWRP Recovery flashed . >> "log.txt"
					fastboot flash recovery pushed/twrp_p6601_7.1_recovery.img
					echo [*] ONCE THE FILE TRANSFER IS COMPLETE HOLD VOLUME UP AND PRESS ANY KEY ON PC 
					echo [*]
					echo [*] IF PHONE DOES NOT REBOOT THEN HOLD VOLUME UP AND POWER UNTILL IT DOES
					echo [*] ON PHONE SELECT RECOVERY FROM BOOT MENU WITH VOLUME KEY THEN SELECT WITH POWER
					echo "[*] press enter to continue"
					read \n
					fastboot reboot
			bash R1-HD-TOOL.sh
					exit
				;;
			"lopestom 2")
					echo "--------------------------------------------------------------------------------"
					echo you chose to instal Lopestom original ported twrp && echo %date% %time% [I] Lopestom TWRP Recovery flashed . >> "log.txt"
					fastboot flash recovery pushed/twrp_p6601_7.1_recovery.img
					echo [*] ONCE THE FILE TRANSFER IS COMPLETE HOLD VOLUME UP AND PRESS ANY KEY ON PC 
					echo [*]
					echo [*] IF PHONE DOES NOT REBOOT THEN HOLD VOLUME UP AND POWER UNTILL IT DOES
					echo [*] ON PHONE SELECT RECOVERY FROM BOOT MENU WITH VOLUME KEY THEN SELECT WITH POWER
					echo "[*] press enter to continue"
					read \n
					fastboot reboot
			bash R1-HD-TOOL.sh
					exit
				;;
				*) echo invalid option;;
				esac
			 bash R1-HD-TOOL.sh
            exit
            ;;
        "Extra Menu 5")
            echo "--------------------------------------------------------------------------------"
			echo "[*] press enter to continue"
                read \n
			bash R1-HD-TOOL.sh
            exit
            ;;
        "SEE INSTRUCTIONS 6")
            echo "--------------------------------------------------------------------------------"
            bash R1-HD-TOOL.sh
            exit
            ;;
        "EXIT 7")
            exit
            ;;
        "VIEW LOG 8")
            bash R1-HD-TOOL.sh
			exit
            ;;
		"CLEAR LOG 9")
            bash R1-HD-TOOL.sh
			exit
            ;;
        *) echo invalid option;;
    esac
done
