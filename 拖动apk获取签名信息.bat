@ECHO off

::����apk���rsa�ļ� 
jar tf %~1 | findstr RSA 1>nul

::��apk�н�ѹrsa�ļ�
jar xf %~1 META-INF/CERT.RSA 1

::��ȡǩ����fingerprints
keytool -printcert -file META-INF/CERT.RSA > %~dp0\sign.txt

type %~dp0\sign.txt

rd /s /Q META-INF

pause
@ECHO on