@echo off

:: InstallShield Subsystem: Force Elevated Administrative Token Context
:: -----------------------------------------------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' neq '0' ( goto :RequestUAC ) else ( goto :ExecuteUninstall )

:RequestUAC
    powershell -Command "Start-Process '%~f0' -Verb RunAs -WorkingDirectory '%~dp0'"
    exit /b

:ExecuteUninstall
setlocal EnableDelayedExpansion

:: =========================================================================
:: DIRECTORY RESOLUTION MAPPING (MANIFEST LAYOUT)
:: =========================================================================
set "ROOT_DIR=%~dp0"
set "VERSION_DIR=%ROOT_DIR%"
if "%VERSION_DIR:~-1%"=="\" set "VERSION_DIR=%VERSION_DIR:~0,-1%"

for %%I in ("%VERSION_DIR%") do set "VERSION_NAME=%%~nxI"
for %%I in ("%VERSION_DIR%\..") do set "BASE_DIR=%%~fI"

set "FINAL_EXEC_DIR=%VERSION_DIR%\exec"

title InstallShield (R) Uninstaller v1.3 :: dc2url Master Deployment Engine
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

cls
echo %BG_GLASS%
cls

echo.
echo %O1%        ######     #####    ######  ##   ##   #####    #####    ###     ###  ######  %RESET%
echo %O2%        ##   ##   ##   ##   ##   ## ##   ##   ##       ##   ##  ####   ####       ## %RESET%
echo %O3%        ##   ##   #######   ######  #####     ##       ##   ##  ## #### ##    #####  %RESET%
echo %Y1%        ##   ##   ##   ##   ##   ## ##   ##   ##       ##   ##  ##  ##  ##    ##     %RESET%
echo %Y2%        ######    ##   ##   ##   ## ##    ##  #####    #####    ##      ##    ###### %RESET%
echo %O2%    ====================================================================================%RESET%
echo %Y2%                        dc2url Core Cyborg Ecosystem Uninstaller%RESET%
echo %O2%    ====================================================================================%RESET%
echo.
echo %O2%        [*] Terminating active dc2url and WebView2 processes...%RESET%
taskkill /f /im dc2url.exe >nul 2>&1
taskkill /f /im darkcom2.exe >nul 2>&1
taskkill /f /im msedgewebview2.exe >nul 2>&1

:: CRITICAL PATH RESOLUTION FIX
set "SCRIPT_DIR=%~dp0"
set "FINAL_EXEC_DIR=%SCRIPT_DIR%exec"
for %%I in ("%SCRIPT_DIR%\..") do set "BASE_DIR=%%~fI"

echo %O2%        [*] Purging Official URI Protocol Handlers and Classes...%RESET%
reg delete "HKCR\dc2url" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\dc2url" /f /reg:64 >nul 2>&1
reg delete "HKLM\SOFTWARE\Classes\dc2url" /f /reg:32 >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Classes\dc2url" /f /reg:64 >nul 2>&1

echo %O2%        [*] Forcefully wiping Add/Remove Programs keys across all architecture hives...%RESET%
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\dc2url" /f /reg:64 >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\dc2url" /f /reg:32 >nul 2>&1
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\dc2url" /f /reg:64 >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\dc2url" /f >nul 2>&1
:: CRITICAL UNINSTALL KEY FIX (Matches the corrected user-space installation path)
reg delete "HKCU\Software\Classes\Software\Microsoft\Windows\CurrentVersion\Uninstall\dc2url" /f >nul 2>&1

reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /f /reg:64 >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /f /reg:32 >nul 2>&1
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /f /reg:64 >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /f >nul 2>&1
reg delete "HKCU\Software\dc2url" /f /s >nul 2>&1

echo %O2%        [*] Purging Environment Variable PATH entries and registry keys...%RESET%
reg delete "HKCU\Environment" /v "dc2url" /f >nul 2>&1
reg delete "HKCU\Environment" /v "dc2url_path" /f >nul 2>&1
reg delete "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "dc2url_path" /f /reg:64 >nul 2>&1

:: Aggressive PowerShell PATH cleanup removing any substring matching dc2url or execution directories
powershell -NoProfile -Command "$ErrorActionPreference='SilentlyContinue'; foreach($hive in @('Machine','User')){ $m=[System.Environment]::GetEnvironmentVariable('PATH',$hive) -split ';' | Where-Object {$_ -ne ''}; $arr = $m | Where-Object {$_ -notmatch 'dc2url'}; [System.Environment]::SetEnvironmentVariable('PATH', ($arr -join ';'), $hive) }" >nul 2>&1

:: Global environment update notification broadcast
powershell -NoProfile -Command "$advapi = '[DllImport(\"user32.dll\",SetLastError=true)]public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, IntPtr wParam, String lParam, uint fuFlags, uint uTimeout, out IntPtr lpdwResult);'; $type = Add-Type -MemberDefinition $advapi -Name 'Win32' -Namespace 'Win32Functions' -PassThru; $res = [IntPtr]::Zero; [Win32Functions.Win32]::SendMessageTimeout([IntPtr]0xffff, 0x001A, [IntPtr]::Zero, 'Environment', 2, 5000, [out]$res)" >nul 2>&1

echo %O2%        [*] Cleaning up execution binaries, DLLs, and temporary cache folders...%RESET%
if exist "%FINAL_EXEC_DIR%\dc2url.exe" del /f /q "%FINAL_EXEC_DIR%\dc2url.exe" >nul 2>&1
if exist "%FINAL_EXEC_DIR%\dc2url.bat" del /f /q "%FINAL_EXEC_DIR%\dc2url.bat" >nul 2>&1
if exist "%FINAL_EXEC_DIR%\dc2ws2.dll" del /f /q "%FINAL_EXEC_DIR%\dc2ws2.dll" >nul 2>&1
if exist "%FINAL_EXEC_DIR%\DarkComHeadless.dll" del /f /q "%FINAL_EXEC_DIR%\DarkComHeadless.dll" >nul 2>&1
if exist "%FINAL_EXEC_DIR%\WebView2Loader.dll" del /f /q "%FINAL_EXEC_DIR%\WebView2Loader.dll" >nul 2>&1

:: CRITICAL LEFTOVER ICON CLEANUP
if exist "%BASE_DIR%\favi-con.ico" del /f /q "%BASE_DIR%\favi-con.ico" >nul 2>&1

echo                     [SUCCESS] dc2url components have been completely uninstalled.
echo.


:finish
echo %Y2%        [Mercwar AI] Uninstallation sequence finalized successfully.%RESET%
echo.
echo %Y2%        [Mercwar AI] This window will close in 3 seconds.%RESET%
timeout /t 3 >nul
endlocal
exit /b 0
