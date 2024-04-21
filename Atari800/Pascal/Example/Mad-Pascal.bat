@echo off
setlocal
cd /D "%~dp0"

if "%1%"=="" (
  echo USAGE: Mad-Pascal.bat ^<inputfile^>.pas
  goto :eof
)

rem Assuming the standard folder structure of WUDSN IDE.
if "%WUDSN_TOOLS_FOLDER%"=="" (

  if "%WUDSN_FOLDER%"=="" (
    echo ERROR: Environment variable WUDSN_FOLDER or WUDSN_TOOLS_FOLDER must be set.
    goto :eof 
  )
  set WUDSN_TOOLS_FOLDER=%WUDSN_FOLDER%\Tools
)

set MP_FOLDER=%WUDSN_TOOLS_FOLDER%\PAS\MP
set MADS_FOLDER=%WUDSN_TOOLS_FOLDER%\ASM\MADS
set PATH=%MP_FOLDER%\bin\windows;%MADS_FOLDER%;%PATH%

set INFILE=%~dp1%~n1
mp %INFILE%.pas -ipath:%MP_FOLDER%\lib -ipath:%MP_FOLDER%\blibs -define:SYMBOL1 -define:SYMBOL2=1234
if ERRORLEVEL 1 (
  echo ERROR: Mad-Pascal error. See error messages above.
  goto :eof
) 

mads %INFILE%.a65 -x -i:%MP_FOLDER%\base -l -o:%INFILE%.xex
if ERRORLEVEL 1 (
  echo ERROR: Mad-Assembler error. See error messages above.
  goto :eof
)

start %INFILE%.xex


