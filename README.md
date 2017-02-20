# DirtyCow-R1_HD
Root BLU R1_HD with DirtyCow and replace frp partition to allow oem unlock

Clone or Download the the prebuilt executables if you like. Keep all files in same folder and run one-click-root.bat. 
to unlock bootloader and install twrp recovery to your BLU R1_HD phone

Or study the .c files included and built them yourself. 


To build: need android source tree.
copy buildables folder with its contents, to external folder in your build tree.
Open terminal at root of android build tree(build tree should be able to be any version source)
lunch your-device.eng (to set variables to your needed arch)
build -j5 dirtycow recowvery-app_process32


@credits

@vampirefo for his v7.1 recovery
@christianrodher for his work on dirty-cow
@ others


