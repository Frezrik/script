@ECHO OFF
echo       -------------------------------------------
echo.&echo.
echo             b.������monkey & echo.
echo             w.������monkey & echo.
echo             q.�˳� & echo.&echo.&echo.&echo.&echo.&echo.

set "select="
set/p select= �������֣����س����� :
if "%select%"=="b" (goto monkey_black) 
if "%select%"=="w" (goto monkey_white) 
if "%select%"=="q" (goto monkey_exit)
 
:monkey_exit
exit

:monkey_black
adb kill-server
adb start-server
adb devices
adb root
adb remount
adb push ./command/black_monkey /system/bin/
adb push ./command/blacklist.txt /system/bin/
adb shell black_monkey &

:monkey_white
adb kill-server
adb start-server
adb devices
adb root
adb remount
adb push ./command/white_monkey /system/bin/
adb push ./command/whitelist.txt /system/bin/
adb shell white_monkey &

pause
@ECHO ON