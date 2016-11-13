::adb shell echo "whoami & end | /data/local/tmp/busybox nc localhost 11112" && echo "exit | /data/local/tmp/busybox nc localhost 11112"
::adb shell /data/local/tmp/busybox nc localhost 11112
adb shell "/data/local/tmp/busybox nc localhost 11112 < /data/local/tmp/test_comands.txt"
pause
:: exit && echo whoami && echo whoami && echo mkdir /data/local/test & echo 
