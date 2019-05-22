@ECHO off

set ndkdir=D:\Develop\Android\SDK\ndk-bundle\toolchains\arm-linux-androideabi-4.9\prebuilt\windows-x86_64\bin
set note=D:\software\Notepad++

echo.

if not exist %~dp0\temp (
    md %~dp0\temp
)

adb pull /data/tombstones/tombstone_00 %~dp0\temp\

echo CPU架构: > %~dp0\temp\symbol.txt
%ndkdir%\arm-linux-androideabi-readelf.exe -A %~1 >> %~dp0\temp\symbol.txt
echo. >> %~dp0\temp\symbol.txt
echo SO依赖: >> %~dp0\temp\symbol.txt
%ndkdir%\arm-linux-androideabi-readelf.exe -d %~1 >> %~dp0\temp\symbol.txt
echo. >> %~dp0\temp\symbol.txt
echo 函数列表: >> %~dp0\temp\symbol.txt
%ndkdir%\arm-linux-androideabi-nm.exe -D %~1 >> %~dp0\temp\symbol.txt

%note%\notepad++.exe %~dp0\temp\symbol.txt

@ECHO on