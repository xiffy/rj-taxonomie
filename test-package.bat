@echo off
setlocal enableDelayedExpansion
echo Building taxonomy-packages
call .\script\cicd\make-artifacts.bat

echo Creating package list and read into PACKAGE_LIST
call .\script\cicd\make-packagelist.bat
set /p TMP_LIST=<artifacts\package_list.env
set "PACKAGE_LIST=%TMP_LIST:~13%"

echo Creating entrypoint list and read into ENTRYPOINT_LIST
call .\script\cicd\make-entrypointlist.bat
set /p TMP_LIST=<taxonomies\entrypoint_list.env
set "ENTRYPOINT_LIST=%TMP_LIST:~16%"

echo calling Arelle

.\script\arelle\arelleCmdLine.exe --validate --file="!ENTRYPOINT_LIST!" --packages "!PACKAGE_LIST!"
