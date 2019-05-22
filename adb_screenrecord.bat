@ECHO off
TITLE 录屏工具
color 3f
CLS
set n=0

adb kill-server
adb start-server

:plus
set /a n+=1

:MENU
ECHO.
ECHO. 按任意键开始录屏...
goto screenrecord

:screenrecord
pause>nul
CLS
ECHO. 1.开始录制
adb shell screenrecord --bugreport --time-limit 180 /sdcard/%n%.mp4
goto pull

:pull
ECHO.
ECHO. 2.视频%n%.mp4已保存在手机储存根目录下
adb pull /sdcard/%n%.mp4 D:/rec
ECHO.
ECHO. 3.视频%n%.mp4已复制到电脑D:/rec目录下
ECHO.
ECHO. 按任意键继续...
pause>nul
goto plus
goto MENU