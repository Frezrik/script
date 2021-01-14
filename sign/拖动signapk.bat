set apk=%~1

java -jar signapk.jar platform.x509.pem platform.pk8 %apk% %apk:~0,-4%_sig.apk
adb install -r %apk:~0,-4%_sig.apk

pause