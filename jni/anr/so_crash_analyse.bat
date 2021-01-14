@ECHO off

set ndkdir=D:\Develop\Android\SDK\\ndk-bundle
set note=D:\software\Notepad++
set tombNum=01

set /p tombNum=������tombstone���[Ĭ��01]:
echo tombstone_%tombNum%

echo ������ֻ���
::adb kill-server
::adb start-server
adb wait-for-device
echo.

if not exist %~dp0\temp (
    md %~dp0\temp
)

adb pull /data/tombstones/tombstone_%tombNum% %~dp0\temp\

call %ndkdir%\ndk-stack -sym %~1 -dump %~dp0\temp\tombstone_%tombNum% > %~dp0\temp\dump.txt

%note%\notepad++.exe %~dp0\temp\dump.txt

::type %~dp0\dump.txt

pause
@ECHO on