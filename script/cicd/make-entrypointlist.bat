@echo off
setlocal enableDelayedExpansion
cd .\taxonomies
set LIST=
for /d %%d in (*) do (
  for %%f  in (%%d\META-INF\t*xml) do (
    rem   find the entrypointname(s) in the taxonomyPackage.xml
    find /i "tp:entryPointDocument" < %%f > _tmp
    rem   read the file -line by line
    for /f "tokens=*" %%l in (_tmp) do (
      rem   splitsen op een dubbele quote is not so easy
      for /f tokens^=2^ delims^=^" %%h in ("%%l") do (
        rem "  <- fiex my code-editor
        echo|set /p="%%h|">> _list.env
      )
    )
  )
)

del _tmp
echo|set /p="ENTRYPOINT_LIST="> entrypoint_list.env
set /p LIST=<_list.env
del _list.env
set "LIST=%LIST:~0,-1%"
echo|set /p="%LIST%">>entrypoint_list.env
@rem   where does the error come from?
exit /b 0
