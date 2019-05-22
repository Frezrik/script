@echo off
echo 请插入手机…
::adb kill-server
::adb start-server
adb wait-for-device

set dest=%~1
echo %dest%

for %%a in (%dest%) do set "b=%%~aa"
    if %b:~0,1%==d (
        goto install_dir
    ) else (
        goto install_file
    )

:install_file
echo 正在安装APK文件  
adb install -r  %dest%
echo 安装完毕！
goto end

:install_dir
for %%i in (%dest%\*.apk) do (
    echo 正在安装：%%i
    adb install -r "%%i"
    )
echo 安装完毕！

:end
::adb kill-server
PAUSE
@echo on