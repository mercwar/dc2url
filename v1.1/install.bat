@echo off
setlocal EnableDelayedExpansion

:: InstallShield Subsystem: Force Elevated Administrative Token Context
:: -----------------------------------------------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% neq 0 ( goto :RequestUAC ) else ( goto :ExecuteSetup )

:RequestUAC
    powershell -Command "Start-Process '%~f0' -Verb RunAs -WorkingDirectory '%~dp0'"
    exit /b

:ExecuteSetup

:: =========================================================================
:: DIRECTORY RESOLUTION MAPPING (MANIFEST LAYOUT)
:: =========================================================================
set "ROOT_DIR=%~dp0"
set "VERSION_DIR=%ROOT_DIR%"
if "%VERSION_DIR:~-1%"=="\" set "VERSION_DIR=%VERSION_DIR:~0,-1%"

for %%I in ("%VERSION_DIR%") do set "VERSION_NAME=%%~nxI"
for %%I in ("%VERSION_DIR%\..") do set "BASE_DIR=%%~fI"

set "FINAL_EXEC_DIR=%VERSION_DIR%\exec"
set "FINAL_EXE_PATH=%FINAL_EXEC_DIR%\dc2url.exe"

set "MIDI_URL=https://raw.githubusercontent.com/mercwar/dc2url/main/sound/transformers.mid"

cd /d "%FINAL_EXEC_DIR%"

title InstallShield (R) Setup Launcher v1.1 :: dc2url Master Deployment Engine

mode con: cols=120 lines=34

chcp 65001 >nul 2>&1
color 0E

reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
for /f %%a in ('echo prompt $E^|cmd') do set "E=%%a"
set "RESET=%E%[0m"
set "BG_GLASS=%E%[48;2;10;10;12m"
set "O1=%E%[38;2;255;68;0m"
set "O2=%E%[38;2;255;110;0m"
set "O3=%E%[38;2;255;153;0m"
set "Y1=%E%[38;2;255;200;0m"
set "Y2=%E%[38;2;255;235;0m"
set "TXT=%E%[38;2;240;240;240m"
set "GRAY=%E%[38;2;115;125;145m"
set "GREEN=%E%[38;2;90;255;120m"

cls
echo %BG_GLASS%
cls


echo %O1%      ######   #####  ######  ##  ##  #####  ######  ###   ### ###### %RESET%%BG_GLASS%
echo %O2%      ##   ## ##   ## ##   ## ## ##   ##     ##   ## #### ####    ###  %RESET%%BG_GLASS%
echo %O3%      ##   ## ####### ######  #####   ##     ##   ## ## ### ##   ##    %RESET%%BG_GLASS%
echo %Y1%      ##   ## ##   ## ##   ## ##  ##  ##     ##   ## ##     ##  # ###  %RESET%%BG_GLASS%
echo %Y2%      ######  ##   ## ##   ## ##  ##   #####  #####  ##     ## ####### %RESET%%BG_GLASS%
echo.
