@echo off
:: InstallShield Subsystem: Force Elevated Administrative Token Context
:: -----------------------------------------------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' neq '0' ( goto :RequestUAC ) else ( goto :ExecuteUninstaller )

:RequestUAC
    powershell -Command "Start-Process '%~f0' -Verb RunAs -WorkingDirectory '%~dp0'"
    exit /b

:ExecuteUninstaller
setlocal EnableDelayedExpansion

:: Store original script directory immediately
set "SCRIPT_DIR=%~dp0"

:: 1. Define Target Paths matching the installer version schema layout dynamically
set "VERSION_TAG=v1.1"
set "TARGET=%ProgramFiles%\dc2url"
set "TARGET_BASE=%TARGET%\%VERSION_TAG%"
set "FINAL_EXEC_DIR=%TARGET_BASE%\exec"

title Eclipse Uninstaller Engine [%VERSION_TAG%]

mode con: cols=120 lines=36
chcp 65001 >nul 2>&1
color 0E

reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
for /f %%a in ('echo prompt $E^|cmd') do set "E=%%a"
set "RESET=%E%[0m"
set "BG_GLASS=%E%[48;2;10;10;12m"
set "R1=%E%[38;2;255;68;0m"
set "R2=%E%[38;2;255;110;0m"
set "R3=%E%[38;2;255;153;0m"
set "Y1=%E%[38;2;255;200;0m"
set "Y2=%E%[38;2;255;235;0m"
set "TXT=%E%[38;2;240;240;240m"

cls
echo %BG_GLASS%
cls

echo.
echo %R1%        ███████╗ ██████╗██╗     ██║██████╗ ███████╗███████╗%RESET%%BG_GLASS%
echo %R2%        ██╔════╝██╔════╝██║     ██║██╔══██╗██╔════╝██╔════╝%RESET%%BG_GLASS%
echo %R1%        █████╗  ██║     ██║     ██║██████╔╝███████╗█████╗  %RESET%%BG_GLASS%
echo %Y1%        ██╔══╝  ██║     ██║     ██║██╔═══╝ ╚════██║██╔══╝  %RESET%%BG_GLASS%
echo %Y2%        ███████╗╚██████╗███████╗██║██║     ███████║███████╗%RESET%%BG_GLASS%
echo %Y2%        ╚══════╝ ╚═════╝╚══════╝╚═╝╚═╝     ╚══════╝╚══════╝%RESET%%BG_GLASS%
echo %R2%    ====================================================================================%RESET%%BG_GLASS%
echo %Y2%                              Eclipse Uninstaller Pipeline :: %VERSION_TAG%%RESET%%BG_GLASS%
echo %R2%    ====================================================================================%RESET%%BG_GLASS%
echo.

:: =========================================================================
:: 1. PROCESS TERMINATION & SHORTCUT PURGE
:: =========================================================================
echo %R2%        [*] Closing active Eclipse programs...%RESET%%BG_GLASS%
taskkill /f /im eclipse.exe >nul 2>&1

echo %R2%        [*] Purging workspace link shortcuts...%RESET%%BG_GLASS%
if exist "%USERPROFILE%\Desktop\Eclipse.lnk" del /f /q "%USERPROFILE%\Desktop\Eclipse.lnk" >nul 2>&1
if exist "%PUBLIC%\Desktop\Eclipse.lnk" del /f /q "%PUBLIC%\Desktop\Eclipse.lnk" >nul 2>&1
if exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Eclipse.lnk" del /f /q "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Eclipse.lnk" >nul 2>&1

:: =========================================================================
:: 2. REGISTRY CLEANUP
:: =========================================================================
echo %R2%        [*] Removing Windows Registry entries...%RESET%%BG_GLASS%

reg delete "HKCU\Software\Eclipse" /f >nul 2>&1
echo %R2%                     [OK] Removing Eclipse..%RESET%%BG_GLASS%
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\eclipse.exe" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\eclipse.exe" /f >nul 2>&1
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\eclipse.exe" /f >nul 2>&1
reg delete "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\eclipse.exe" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Eclipse" /f >nul 2>&1
reg delete "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Eclipse" /f >nul 2>&1
echo %R2%                     [OK] Removed Eclipse...%RESET%%BG_GLASS%


:: =========================================================================
:: 3. ENVIRONMENT PATH PURGE & BROADCAST
:: =========================================================================
echo %R2%        [*] Removing Eclipse system environment variables...%RESET%%BG_GLASS%

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v eclipse_path /f >nul 2>&1

powershell -Command "$m=[System.Environment]::GetEnvironmentVariable('PATH','Machine'); if($m -split ';' -contains '%FINAL_EXEC_DIR%'){$new=($m -split ';' | Where-Object {$_ -neq '%FINAL_EXEC_DIR%'}) -join ';'; [System.Environment]::SetEnvironmentVariable('PATH',$new,'Machine')}" >nul 2>&1
powershell -Command "$p=[System.Environment]::GetEnvironmentVariable('PATH','User'); if($p -split ';' -contains '%FINAL_EXEC_DIR%'){$new=($p -split ';' | Where-Object {$_ -neq '%FINAL_EXEC_DIR%'}) -join ';'; [System.Environment]::SetEnvironmentVariable('PATH',$new,'User')}" >nul 2>&1

powershell -Command "$advapi = '[DllImport(\"user32.dll\",SetLastError=true)]public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, IntPtr wParam, String lParam, uint fuFlags, uint uTimeout, out IntPtr lpdwResult);'; $type = Add-Type -MemberDefinition $advapi -Name 'Win32' -Namespace 'Win32Functions' -PassThru; $res = [IntPtr]::Zero; [Win32Functions.Win32]::SendMessageTimeout([IntPtr]0xffff, 0x001A, [IntPtr]::Zero, 'Environment', 2, 5000, [out]$res)" >nul 2>&1

echo                     [OK] System environment updated.

:: =========================================================================
:: 4. FILESYSTEM CLEANUP (TARGETED FILE REMOVAL ONLY)
:: =========================================================================
echo %R2%        [*] Deleting Eclipse application files...%RESET%%BG_GLASS%

if exist "%FINAL_EXEC_DIR%\eclipse.exe" del /f /q "%FINAL_EXEC_DIR%\eclipse.exe" >nul 2>&1
if exist "%FINAL_EXEC_DIR%\menu.json" del /f /q "%FINAL_EXEC_DIR%\menu.json" >nul 2>&1

:: Clean up directory tree nodes only if they are now totally empty
rmdir "%FINAL_EXEC_DIR%" >nul 2>&1
rmdir "%TARGET_BASE%" >nul 2>&1
rmdir "%TARGET%" >nul 2>&1

echo.
echo %R3%    ====================================================================================%RESET%%BG_GLASS%
echo %Y1%                        UNINSTALLATION COMPLETE%RESET%%BG_GLASS%
echo %R3%    ====================================================================================%RESET%%BG_GLASS%
echo.

echo %Y1%        Eclipse has been removed from your computer.%RESET%
echo.

set "REINSTALL="
set /p "REINSTALL=%Y2%        Would you like to reinstall Eclipse now? (Y/N): %RESET%"

if /i "%REINSTALL%"=="y" (
    if exist "%SCRIPT_DIR%setup.bat" (
        call "%SCRIPT_DIR%setup.bat"
    ) else if exist "%~dp0setup.bat" (
        call "%~dp0setup.bat"
    ) else (
        echo [!] Could not locate setup.bat inside the uninstaller working environment.
        pause
    )
)

exit /b 0
