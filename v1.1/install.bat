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

mode con: cols=140 lines=38

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

echo %O1%        ██████╗  █████╗ ██████╗ ██╗  ██╗  ██████╗ ██████╗ ███╗   ███╗██████╗ %RESET%
echo %O2%        ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝ ██╔════╝██╔═══██╗████╗ ████║╚════██╗%RESET%
echo %O3%        ██║  ██║███████║██████╔╝█████╔╝  ██║     ██║   ██║██╔████╔██║ █████╔╝%RESET%
echo %Y1%        ██║  ██║██╔══██║██╔══██║██╔══██║ ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ %RESET%
echo %Y2%        ██████╔╝██║  ██║██║  ██║██║  ██║ ╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗%RESET%
echo %Y2%        ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝%RESET%
echo.
echo %O2%    ====================================================================================%RESET%
echo %Y2%                        dc2url Core Cyborg Ecosystem Installer%RESET%
echo %O2%    ====================================================================================%RESET%
echo.

:: ============================================================
:: PHASE 1: VALIDATION & SECURITY LAYER
:: ============================================================
if not exist "%FINAL_EXE_PATH%" (
    echo %O1%        [AVIS FAILED] Execution binaries are missing in: %FINAL_EXEC_DIR%%RESET%
    goto :finish
)

echo %O2%        [*] Granting full write access permissions to %VERSION_DIR%...%RESET%
icacls "%VERSION_DIR%" /grant Users:(OI)(CI)F /t >nul 2>&1

:: ============================================================
:: PHASE 2: SUBSYSTEM & RUNTIME CODES VERIFICATION
:: ============================================================
echo %O2%        [*] Processing OLE/COM and System DLL Registrations...%RESET%
if exist "%FINAL_EXEC_DIR%\dc2ws2.dll" (
                        [SUCCESS] dc2ws2.dll network subsystem ready.
)
if exist "%FINAL_EXEC_DIR%\DarkComHeadless.dll" (
                        [SUCCESS] DarkComHeadless.dll ready.
)
if exist "%FINAL_EXEC_DIR%\WebView2Loader.dll" (
                        [SUCCESS] WebView2Loader.dll ready.
)

:: Generate wrapper execution path targets
echo @echo off > "%FINAL_EXEC_DIR%\dc2url.bat"
echo "%FINAL_EXEC_DIR%\dc2url.exe" %%* >> "%FINAL_EXEC_DIR%\dc2url.bat"
                        [SUCCESS] installed 'dc2url.bat' successfully.

:: ============================================================
:: PHASE 3: REGISTRY SANITIZATION & PROTOCOL REGISTER
:: ============================================================
echo %O2%        [*] Registering Official URI Protocol Handler...%RESET%
reg add "HKLM\SOFTWARE\Classes\dc2url" /ve /t REG_SZ /d "URL:dc2url Protocol" /f /reg:64 >nul 2>&1
reg add "HKLM\SOFTWARE\Classes\dc2url" /v "URL Protocol" /t REG_SZ /d "" /f /reg:64 >nul 2>&1
reg add "HKLM\SOFTWARE\Classes\dc2url\shell\open\command" /ve /t REG_SZ /d "\"%FINAL_EXE_PATH%\" \"%%1\"" /f /reg:64 >nul 2>&1

echo %O2%        [*] Auto Configuring dc2url for Windows App Paths...%RESET%
reg add "HKCU\Software\dc2url\Launcher" /v "InstallPath" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f >nul 2>&1
reg add "HKCU\Software\dc2url\Launcher" /v "NetworkSubsystem" /t REG_SZ /d "%FINAL_EXEC_DIR%\dc2ws2.dll" /f >nul 2>&1
reg add "HKCU\Software\dc2url\Launcher" /v "HeadlessEngine" /t REG_SZ /d "%FINAL_EXEC_DIR%\DarkComHeadless.dll" /f >nul 2>&1

:: Global Native Redirections
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /ve /t REG_SZ /d "%FINAL_EXE_PATH%" /f /reg:64 >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f /reg:64 >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /ve /t REG_SZ /d "%FINAL_EXE_PATH%" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f >nul 2>&1

:: SysWOW64 Redundancy Safety Layers
reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /ve /t REG_SZ /d "%FINAL_EXE_PATH%" /f /reg:64 >nul 2>&1
reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f /reg:64 >nul 2>&1
reg add "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /ve /t REG_SZ /d "%FINAL_EXE_PATH%" /f >nul 2>&1
reg add "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f /reg:64 >nul 2>&1

echo %O2%        [*] Auto Registering Uninstaller Keys...%RESET%

:: 1. Check for Administrative Privileges before writing to HKLM
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo %O2%[INFO] Running in standard user context. Skipping HKLM registration...%RESET%
    goto :REGISTER_HKCU
)

echo %O2%[*] Auto Registering dc2url into HKLM Apps ...%RESET%
for %%K in (
    "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\dc2url"
) do (
    reg add %%K /v "DisplayName" /t REG_SZ /d "dc2url" /f /reg:64 >nul 2>&1
    reg add %%K /v "UninstallString" /t REG_SZ /d "\"%VERSION_DIR%\uninstall.bat\"" /f /reg:64 >nul 2>&1
    reg add %%K /v "InstallLocation" /t REG_SZ /d "%VERSION_DIR%\\" /f /reg:64 >nul 2>&1
    reg add %%K /v "DisplayIcon" /t REG_SZ /d "%BASE_DIR%\favi-con.ico" /f /reg:64 >nul 2>&1
    reg add %%K /v "DisplayVersion" /t REG_SZ /d "%VERSION_NAME%" /f /reg:64 >nul 2>&1
    reg add %%K /v "Publisher" /t REG_SZ /d "Mercwar AI" /f /reg:64 >nul 2>&1
    reg add %%K /v "EstimatedSize" /t REG_DWORD /d 1024 /f /reg:64 >nul 2>&1
    reg add %%K /v "NoModify" /t REG_DWORD /d 1 /f /reg:64 >nul 2>&1
    reg add %%K /v "NoRepair" /t REG_DWORD /d 1 /f /reg:64 >nul 2>&1
)

:REGISTER_HKCU
echo %O2%[*] Auto Registering dc2url into HKCU User Apps ...%RESET%
for %%K in (
    "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\dc2url"
) do (
    reg add %%K /v "DisplayName" /t REG_SZ /d "dc2url" /f >nul 2>&1
    reg add %%K /v "UninstallString" /t REG_SZ /d "\"%VERSION_DIR%\uninstall.bat\"" /f >nul 2>&1
    reg add %%K /v "InstallLocation" /t REG_SZ /d "%VERSION_DIR%\\" /f >nul 2>&1
    reg add %%K /v "DisplayIcon" /t REG_SZ /d "%BASE_DIR%\favi-con.ico" /f >nul 2>&1
    reg add %%K /v "DisplayVersion" /t REG_SZ /d "%VERSION_NAME%" /f >nul 2>&1
    reg add %%K /v "Publisher" /t REG_SZ /d "Mercwar AI" /f >nul 2>&1
    reg add %%K /v "EstimatedSize" /t REG_DWORD /d 1024 /f >nul 2>&1
    reg add %%K /v "NoModify" /t REG_DWORD /d 1 /f >nul 2>&1
    reg add %%K /v "NoRepair" /t REG_DWORD /d 1 /f >nul 2>&1
)

echo %O2% [SUCCESS] Registry registration sequence completed cleanly.%RESET%

:: ============================================================
:: PHASE 4: ENVIRONMENT VARIABLES & NOTIFICATION PROPAGATION
:: ============================================================
echo %O2%        [AVIS] Saving config and completing registration...%RESET%

reg add "HKCU\Environment" /v "dc2url_path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f >nul 2>&1
reg add "HKCU\Environment" /v "dc2url" /t REG_SZ /d "%FINAL_EXE_PATH%" /f >nul 2>&1

:: Properly prepend FINAL_EXEC_DIR to PATH without duplicates
powershell -NoProfile -InputFormat None -Command "$ErrorActionPreference='SilentlyContinue'; $m=[System.Environment]::GetEnvironmentVariable('PATH','Machine') -split ';' | Where-Object {$_ -ne ''}; if($m -notcontains '%FINAL_EXEC_DIR%'){ [System.Environment]::SetEnvironmentVariable('PATH',((@('%FINAL_EXEC_DIR%')+$m) -join ';'),'Machine') }" >nul 2>&1
powershell -NoProfile -InputFormat None -Command "$ErrorActionPreference='SilentlyContinue'; $p=[System.Environment]::GetEnvironmentVariable('PATH','User') -split ';' | Where-Object {$_ -ne ''}; if($p -notcontains '%FINAL_EXEC_DIR%'){ [System.Environment]::SetEnvironmentVariable('PATH',((@('%FINAL_EXEC_DIR%')+$p) -join ';'),'User') }" >nul 2>&1

echo %O2%        [*] Broadcasting environment update to Windows Shell...%RESET%
powershell -NoProfile -InputFormat None -Command "$api = '[DllImport(\"user32.dll\", SetLastError=true)] public static extern bool SendNotifyMessage(IntPtr hWnd, uint Msg, IntPtr wParam, String lParam);'; $type = Add-Type -MemberDefinition $api -Name 'Win32' -Namespace 'Win32Functions' -PassThru; [Win32Functions.Win32]::SendNotifyMessage([IntPtr]0xffff, 0x001A, [IntPtr]::Zero, 'Environment') | Out-Null" >nul 2>&1

echo.
echo %O2%                    [SUCCESS] dc2url is now fully installed and at your command!%RESET%

set "MIDI_OUTPUT=%BASE_DIR%\sound\transformers.mid"
if not exist "%BASE_DIR%\sound" mkdir "%BASE_DIR%\sound"

echo.
echo %O2%        [*] Detecting sound settings ...%RESET%

set "SOUND_SETTING=off"
for /f "tokens=2*" %%A in ('reg query "HKCU\Software\Eclipse\Launcher" /v "SoundArg" 2^>nul') do (
    set "SOUND_SETTING=%%B"
)

if /i "%SOUND_SETTING%"=="on" (
    if exist "%MIDI_OUTPUT%" del /f /q "%MIDI_OUTPUT%" >nul 2>&1
    
    "%FINAL_EXEC_DIR%\dc2url.exe" -s -dc2ws2 "%MIDI_URL%" -o "%MIDI_OUTPUT%"
    
    echo.
    if exist "%MIDI_OUTPUT%" (
        for %%I in ("%MIDI_OUTPUT%") do set "FILESIZE=%%~zI"
        
        if !FILESIZE! LSS 1000 goto bad_file
        echo.
        echo %Y2%        [Transformation] TRANSFORM... %RESET%
        start "" "%MIDI_OUTPUT%"
        
    ) else (
        echo [AVIS ERROR] Binary download failed.
    )
) else (
    echo %TXT%        [INFO] Skipping audio playback.%RESET%
)
goto finish

:bad_file
echo [AVIS FAILURE] File size is too small (!FILESIZE! bytes). Check network or proxy.

:finish
echo.
echo %Y2%        [To uninstall, go to Add/Remove Programs or run uninstall.bat]%RESET%
echo.
echo %TXT%        Your copy of dc2url in now installed cmd:\ dc2url -nojs [curl compat]...%RESET%
echo.

if not exist "%BASE_DIR%\setup.bat" goto :no_setup

choice /c YN /n /m "%O2%        [?] Update/Install/Re-install Eclipse for dc2url v1.1 ? (Y/N)%RESET%"

if errorlevel 2 goto :skip_setup
if errorlevel 1 goto :run_setup

:run_setup
echo %O2%        [*] Launching local setup...%RESET%
call "%BASE_DIR%\setup.bat"
goto :setup_end

:skip_setup
echo %Y2%        [INFO] Exiting...%RESET%
goto :setup_end

:no_setup
echo %Y2%        [error] Check Installation %FINAL_EXEC_DIR%.%RESET%

:setup_end
echo.
echo.
endlocal
exit /b 0
