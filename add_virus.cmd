@echo off
color 2f
:menu

cls
echo.
echo a) /data/app
echo b) /system/app
echo c) /system/xbin
echo d) /system/priv-app

echo.
set /p opt= Select path: 

if %opt% == a set path=/data/app
if %opt% == a set cmd_file=data-app.cmd

if %opt% == b set path=/system/app
if %opt% == b set cmd_file=system-app.cmd

if %opt% == c set path=/system/xbin
if %opt% == c set cmd_file=system-xbin.cmd

if %opt% == d set path=/system/priv-app
if %opt% == d set cmd_file=system-privapp.cmd


:file_name

copy res/%cmd_file% res/%cmd_file%.tmp>nul
set /p file= File name (e=exit): 
if %file% == e goto exit

echo @adb shell ^"[ -f %path%/%file% ] ^&^& "su -c 'rm %path%/%file%'"^>nul>>res/%cmd_file%.tmp
echo. >>res/%cmd_file%.tmp

goto file_name

:exit
cd %cd%/res
type %cmd_file% >> %cmd_file%.tmp
del /q %cmd_file%
ren %cmd_file%.tmp %cmd_file%