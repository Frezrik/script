@echo off
echo ������ֻ���
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
echo ���ڰ�װAPK�ļ�  
adb install -r  %dest%
echo ��װ��ϣ�
goto end

:install_dir
for %%i in (%dest%\*.apk) do (
    echo ���ڰ�װ��%%i
    adb install -r "%%i"
    )
echo ��װ��ϣ�

:end
::adb kill-server
PAUSE
@echo on