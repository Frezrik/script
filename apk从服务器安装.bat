@ECHO off

::�������ڻ�ȡ�����������µ�apk����װ
set src_dir="apk�ķ�����·��"
set filename=

echo ������ֻ���
::adb kill-server
::adb start-server
adb wait-for-device
echo.

::��ȡ����Ŀ¼
for /f %%a in ('dir %src_dir% /o-d /tc /b') do (
    set filename=%%a
    if not %%a == ""  (
        goto ins
    )
)

:ins
echo 2.��װ%filename%�µ�APK�ļ�
for %%i in (%src_dir%\%filename%\debug\*.apk) do (
    echo   ���ڰ�װ:%%~nxi
    adb install -r "%%i"
)

echo.
echo 3.��װ��ϣ�
echo.

::adb kill-server

pause

@ECHO on