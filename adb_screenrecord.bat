@ECHO off
TITLE ¼������
color 3f
CLS
set n=0

adb kill-server
adb start-server

:plus
set /a n+=1

:MENU
ECHO.
ECHO. ���������ʼ¼��...
goto screenrecord

:screenrecord
pause>nul
CLS
ECHO. 1.��ʼ¼��
adb shell screenrecord --bugreport --time-limit 180 /sdcard/%n%.mp4
goto pull

:pull
ECHO.
ECHO. 2.��Ƶ%n%.mp4�ѱ������ֻ������Ŀ¼��
adb pull /sdcard/%n%.mp4 D:/rec
ECHO.
ECHO. 3.��Ƶ%n%.mp4�Ѹ��Ƶ�����D:/recĿ¼��
ECHO.
ECHO. �����������...
pause>nul
goto plus
goto MENU