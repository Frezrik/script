@echo off

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

@rem Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windowz variants

if not "%OS%" == "Windows_NT" goto win9xME_args
if "%@eval[2+2]" == "4" goto 4NT_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:title
cls
@echo.
@echo ----------------------------------------------
echo     1.编译生成debug版本apk，用于手动测试
echo     2.编译生成release版本apk，用于自动化测试
echo     3.编译生成general版本apk，用于非pax机型使用
echo     4.只编译release版本Paydroid Tester
echo     5.安装apk
echo     6.退出
set select=4
set /p select=请选择[1,2,3,4,5]:
echo %select%
@echo ----------------------------------------------
@echo.
if "%select%"=="1" goto debug
if "%select%"=="2" goto release
if "%select%"=="3" goto general
if "%select%"=="4" goto test
if "%select%"=="5" goto install
if "%select%"=="6" goto end
goto title

:debug
echo 编译debug版本apk
set CMD_LINE_ARGS=clean assembleDebug uiautomatorservice:assembleAndroidTest
set build_apk=debug
goto execute

:release
set CMD_LINE_ARGS=clean assembleRelease uiautomatorservice:assembleAndroidTest
set build_apk=release
goto execute

:general
set CMD_LINE_ARGS=clean assembleGeneral
set build_apk=general
goto execute

:test
set CMD_LINE_ARGS=app:clean app:assembleRelease
set build_apk=release
goto execute

:install
echo Please connect the phone...
adb kill-server
pax_adb kill-server
echo Uninstalling...
pax_adb uninstall com.pax.paydroid.tester
pax_adb uninstall com.pax.paydroid.tester.service
pax_adb uninstall com.pax.paydroid.uiautomatorservice
pax_adb uninstall com.pax.paydroid.uiautomatorservice.test
echo Installing...
for %%i in (.\build\*.apk) do (
	echo install: %%i
	pax_adb install -r "%%i" | findstr Failure && goto releaseInstall
	)
echo Install finish
pause
goto title

:releaseInstall
cls
echo 请将build目录下的apk签名后,再移动到build目录
pause
echo Installing...
for %%i in (.\build\*_sign.apk) do (
	echo install: %%i
	pax_adb install -r "%%i"
	)
echo Install finish
pause
goto title

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\gradle\wrapper\gradle-wrapper.jar

@rem Execute Gradle
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %GRADLE_OPTS% "-Dorg.gradle.appname=%APP_BASE_NAME%" -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %CMD_LINE_ARGS%

:move
move .\app\build\outputs\apk\app-%build_apk%.apk .\build\paydroid_tester.apk
move .\service\build\outputs\apk\service-%build_apk%.apk .\build\paydroid_service.apk
move .\uiautomatorservice\build\outputs\apk\uiautomatorservice-%build_apk%.apk .\build\paydroid_uiautomatorservice.apk
move .\uiautomatorservice\build\outputs\apk\uiautomatorservice-debug-androidTest.apk .\build\paydroid_uiautomatorservice_test.apk
cls
echo %build_apk%版本apk已编译完成,请见build目录
pause
goto title

:end
@pax_adb systool startproc Activity com.pax.paydroid.tester com.pax.paydroid.tester.ui.PaydroidTesterActivity >NUL
@adb kill-server
@pax_adb kill-server
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable GRADLE_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%GRADLE_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal
