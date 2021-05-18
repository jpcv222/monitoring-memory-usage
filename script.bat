@echo off

setlocal EnableDelayedExpansion
set total=0

REM If no process name was entered on the command line, prompt for the process
REM name.
IF [%1]==[] (
   set /p pname="Process name: "
) ELSE (
   set pname=%1
)

for /f "tokens=5" %%i in ('tasklist /fi "imagename eq %pname%" ^| findstr " K$"
') do (
   set pmemuse=%%i
   REM eliminate the comma from the number
   set pmemuse=!pmemuse:,=!
   set /a total=!total! + !pmemuse!
)
echo %total%

IF %total% GTR 2621440 (
    taskkill /IM chrome.exe /F
    start chrome.exe
)