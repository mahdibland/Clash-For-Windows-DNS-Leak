@echo off && setlocal enabledelayedexpansion

:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  

set /a index=0
set networks[0] =""

for /f "delims=," %%a in ('Getmac /v /nh /fo csv') do (
  set current=%%a%
  echo !index! - !current:"=!
  set networks[!index!]=!current:"=!
  if !index! == 0 (
    set /a index=%index%+1
  ) else (
    if !index! == 1 (
      set /a index=%index%+2
  ) else (
    if !index! == 2 (
      set /a index=%index%+3
  ) else (
    if !index! == 3 (
      set /a index=%index%+4
  ) else (
    if !index! == 4 (
      set /a index=%index%+5
  ) else (
    if !index! == 5 (
      set /a index=%index%+6
  ) else (
    if !index! == 6 (
      set /a index=%index%+7
  ) else (
    if !index! == 7 (
      set /a index=%index%+8
  ) else (
    if !index! == 8 (
      set /a index=%index%+9
  ) else (
    if !index! == 9 (
      set /a index=%index%+10
  ) else (
    if !index! == 10 (
      set /a index=%index%+11
  ) else (
    if !index! == 11 (
      set /a index=%index%+12
  ) else (
    if !index! == 12 (
      set /a index=%index%+13
  ) else (
    if !index! == 13 (
      set /a index=%index%+14
  ) else (
    if !index! == 14 (
      set /a index=%index%+15
  ) else (
    if !index! == 15 (
      set /a index=%index%+16
  ) else (
    if !index! == 16 (
      set /a index=%index%+17
  ) else (
    if !index! == 17 (
      set /a index=%index%+18
  ) else (
    if !index! == 18 (
      set /a index=%index%+19
  ) else (
    if !index! == 19 (
      set /a index=%index%+20
  ))))))))))))))))))))
)

echo ***************************
set /p "id=Interface Number: "

echo Selected !networks[%id%]!

if [%id%] == [] (
  echo id is empty. re run the file
  pause
  exit
)

echo --------------------------------
echo 1- Add Dns
echo 2- Remove Dns
echo --------------------------------

set /p "option=Choose an option: "

if %option% == 1  (
  netsh interface ipv4 set dnsservers !networks[%id%]! static 198.18.0.2 validate=no
  netsh interface ipv6 set interface !networks[%id%]! routerdiscovery=disabled
  ipconfig /release6
  ipconfig /flushdns
)

if %option% == 2  (
  netsh interface ipv4 delete dnsserver !networks[%id%]! 198.18.0.2 validate=no
  netsh interface ipv6 set interface !networks[%id%]! routerdiscovery=enabled
  ipconfig /renew6
  ipconfig /flushdns
)

pause