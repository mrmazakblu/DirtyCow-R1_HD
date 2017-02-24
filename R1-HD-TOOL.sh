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
			echo "press enter to exit"
                read \n
            sudo $ADB kill-server
            bash R1-HD-TOOL.sh
            exit 
            ;;
        "Do Bootloader Unlock 3")
            echo "--------------------------------------------------------------------------------"
			echo "[*] press enter to exit"
                read \n
            sudo $ADB kill-server
            bash R1-HD-TOOL.sh
            exit
            ;;
        "Flash TWRP 4")
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
