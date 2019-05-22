@ECHO off

::查找apk里的rsa文件 
jar tf %~1 | findstr RSA 1>nul

::从apk中解压rsa文件
jar xf %~1 META-INF/CERT.RSA 1

::获取签名的fingerprints
keytool -printcert -file META-INF/CERT.RSA > %~dp0\sign.txt

type %~dp0\sign.txt

rd /s /Q META-INF

pause
@ECHO on