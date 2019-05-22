@ECHO off

set ndkdir=D:\Develop\Android\SDK\\ndk-bundle
set note=D:\software\Notepad++

echo Çë²åÈëÊÖ»ú¡­
::adb kill-server
::adb start-server
adb wait-for-device
echo.

if not exist %~dp0\temp (
    md %~dp0\temp
)

adb pull /data/tombstones/tombstone_00 %~dp0\temp\

call %ndkdir%\ndk-stack -sym %~1 -dump %~dp0\temp\tombstone_00 > %~dp0\temp\dump.txt

%note%\notepad++.exe %~dp0\temp\dump.txt

::type %~dp0\dump.txt

pause
@ECHO on