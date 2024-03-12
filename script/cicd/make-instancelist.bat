@echo off
setlocal enableDelayedExpansion
cd .\instances
set LIST=
for %%f in (*xbrl) do (
    echo|set /p=".\instances\%%f|">> _list.env
)
echo|set /p="INSTANCE_LIST="> instance_list.env
set /p LIST=<_list.env
del _list.env
@REM Remove last character, which is a '|'
set "LIST=%LIST:~0,-1%"
echo|set /p="%LIST%">>instance_list.env
exit /b 0
