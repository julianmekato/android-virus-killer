@echo off
color 2f
:menu
cd /d %cd%/res
adb kill-server>nul
taskkill /f /im adb.exe>nul
taskkill /f /im xadb.exe>nul
cls
echo.
echo --------------------------------------------------------------------
echo [*] Before begin:   
echo     (1) Reset to factory your device
echo     (2) Root your infected device
echo     (3) Install Busybox (open it an tap on install)
echo --------------------------------------------------------------------
echo More information at: github.com/julianmekato/android-virus-killer/
adb -a wait-for-device
echo.
echo (x)  All
echo (a) /data/app
echo (b) /system/app
echo (c) /system/xbin
echo (d) /system/priv-app
echo.
:path
set /p opt= Choose a path to clean: 
echo.
	echo Cleaning device, please wait...
	adb shell "su -c 'mount -o rw,remount /system'">nul

if %opt% == x goto x
if %opt% == a goto a
if %opt% == b goto b
if %opt% == c goto c
if %opt% == d goto d

:x

:a
	echo.
	adb shell "su -c 'chattr -iaA /data/app/*'">nul
	echo Cleaning /data/app...
	start /B /MIN /WAIT data-app.cmd
	if %opt% == a goto end

:b
	echo.
	adb shell "su -c 'chattr -iaA /system/app/*'">nul
	echo Cleaning /system/app...
	start /B /MIN /WAIT system-app.cmd
	if %opt% == b goto end

:c
	echo.
	adb shell "su -c 'chattr -iaA /system/xbin/*'">nul
	echo Cleaning /system/xbin...
	start /B /MIN /WAIT system-xbin.cmd
	if %opt% == c goto end

:d
	echo.
	adb shell "su -c 'chattr -iaA /system/priv-app/*'">nul
	echo Cleaning /system/priv-app...
	start /B /MIN /WAIT system-privapp.cmd
	if %opt% == d goto end

:end
echo.
goto path