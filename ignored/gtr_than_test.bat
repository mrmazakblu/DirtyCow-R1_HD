@echo off &setlocal
for /f "tokens=1*" %%i in (working\unlockability.txt) do if "%%i" GTR "1" echo "%%i %%j" & set alert=%%i
IF DEFINED alert ECHO something found %alert% files
pause

::@ECHO OFF
::SETLOCAL
::(set alert=)
::for /f %%i in (working\unlock_string.txt) do if %%i gtr 620 set alert=%%i
::IF DEFINED alert ECHO sendmail found %alert% files
::pause
