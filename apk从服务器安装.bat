@ECHO off

::根据日期获取服务器下最新的apk并安装
set src_dir="apk的服务器路径"
set filename=

echo 请插入手机…
::adb kill-server
::adb start-server
adb wait-for-device
echo.

::获取最新目录
for /f %%a in ('dir %src_dir% /o-d /tc /b') do (
    set filename=%%a
    if not %%a == ""  (
        goto ins
    )
)

:ins
echo 2.安装%filename%下的APK文件
for %%i in (%src_dir%\%filename%\debug\*.apk) do (
    echo   正在安装:%%~nxi
    adb install -r "%%i"
)

echo.
echo 3.安装完毕！
echo.

::adb kill-server

pause

@ECHO on