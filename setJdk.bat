@echo off
rem WHERE YOUR JAVA VERSIONS ARE INSTALLED, LEAVE \ AT THE END OF THE LOCATION
set "javaDir=C:\Program Files\Eclipse Adoptium\"
rem ALL FOLDER WITH JAVA SHOULD'VE SAME PREFIX AND THEN MAJOR JAVA VERSION AFER
rem ADD THIS PREFIX HERE, FOR ME JAVA FOLDERS ARE NAMED jdk-11[...], jdk-18[...] etc.
set "javaPrefix=jdk-"

rem ########### SHOULDN'T HAVE TO MODIFY ###########
rem Get wanted java version from input.
rem TODO: Verify that there is input.
set javaVersion=%~1
echo Setting up java %javaVersion%

rem Construct a string which should be prefix of wanted java folder (jdk-11 fe.)
set searchString=%javaPrefix%%javaVersion%
rem Call function that should find the folder and save it to JAVA_DIR
CALL:JavaDir "%javaDir%", "%searchString%", JAVA_DIR

rem TODO: It would be good idea to check here if anything was found. Or do the check in JavaDir function. 

rem SETTING JAVA HOME
set JAVA_HOME=%JAVA_DIR%
rem Line below will make change to local registry, you can comment it out if you only use cmd and don't mind java version to be set temporarily.
setx JAVA_HOME "%JAVA_HOME%"
rem To set java globally comment line above (add rem at the beggining) and uncomment line below (remove rem :) ) / script will work only as admin
rem setx JAVA_HOME "%JAVA_HOME%" /M

rem This will add path to cmd locally. Thanks to this line, if you're using cmd you should be able to use your java version straight away
set Path=%JAVA_HOME%\bin;%Path%"

echo You should get output with your java version now. If it fails something went wrong
rem print java version, this is using cmd so it will version from %Path%
java -version
echo Java %javaVersion% hopefully activated. End of script.

goto:eof

:JavaDir
rem Get values from call
set "javaPath=%~1"
set "prefix=%~2"
rem Look for folder matching path/prefixJavaVersion*
for /f "delims=" %%a in ('dir /b "%javaPath%%prefix%*"') do set "name=%%a"
rem Set path and folder folder to third parameter with which function was invoked
set "%~3=%javaPath%%name%"
