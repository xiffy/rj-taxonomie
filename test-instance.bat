@echo off
setlocal enableDelayedExpansion

if "%~1"=="" (
  call :build
  echo Gathering test instances
  call .\script\cicd\make-instancelist.bat
  set /p TMP_LIST=<instances\instance_list.env
  @REM remove INSTANCE_LIST= from the string (github needs that)
  set "INSTANCE_LIST=!TMP_LIST:~14!"
  echo testing all instances
) else if "%~1" == "--instance" (
  call :build
  echo testing instance: %2
  set "INSTANCE_LIST=%2"
) else (
  echo Usage: test-instance  to test all instances, or
  echo        test-instance --instance 'instances\file-to-test.xbrl'
  echo        where 'instances\file-to-test.xbrl' can be a single file or a pipe '^|' delimited list
  goto:eof
)
"C:\Program Files\Arelle\arelleCmdLine.exe" --packages "!PACKAGE_LIST!" --file "!INSTANCE_LIST!" -v
@REM --logFile arelle-log.xml
goto :eof

:build
  echo Building taxonomy-packages
  call .\script\cicd\make-artifacts.bat
  set /p TMP_LIST=<artifacts\package_list.env
  @REM remove PACKAGE_LIST= from the string (github needs that)
  set "PACKAGE_LIST=%TMP_LIST:~13%"
  goto :eof
