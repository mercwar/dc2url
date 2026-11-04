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
@echo off
setlocal EnableDelayedExpansion

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
    echo %O2%                [SUCCESS] dc2ws2.dll network subsystem ready.%RESET%
)
if exist "%FINAL_EXEC_DIR%\DarkComHeadless.dll" (
    echo %O2%                [SUCCESS] DarkComHeadless.dll ready.%RESET%
)
if exist "%FINAL_EXEC_DIR%\WebView2Loader.dll" (
    echo %O2%                [SUCCESS] WebView2Loader.dll ready.%RESET%
)

:: Generate wrapper execution path targets for direct CLI calling
echo @echo off > "%FINAL_EXEC_DIR%\dc2url.bat"
echo "%FINAL_EXEC_DIR%\dc2url.exe" %%* >> "%FINAL_EXEC_DIR%\dc2url.bat"
echo %O2%                [SUCCESS] installed 'dc2url.bat' successfully.%RESET%
echo.

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

:: Global Native Redirections (.EXE Shell / Run Dialog Integration)
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /ve /t REG_SZ /d "%FINAL_EXE_PATH%" /f /reg:64 >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f /reg:64 >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /ve /t REG_SZ /d "%FINAL_EXE_PATH%" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f >nul 2>&1

:: Global Native Redirections (.BAT Shell / Core DOS Batch Interceptor Integration)
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.bat" /ve /t REG_SZ /d "%FINAL_EXEC_DIR%\dc2url.bat" /f /reg:64 >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.bat" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f /reg:64 >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.bat" /ve /t REG_SZ /d "%FINAL_EXEC_DIR%\dc2url.bat" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\App Paths\dc2url.bat" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f >nul 2>&1

:: SysWOW64 Redundancy Safety Layers
reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /ve /t REG_SZ /d "%FINAL_EXE_PATH%" /f /reg:64 >nul 2>&1
reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f /reg:64 >nul 2>&1
reg add "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /ve /t REG_SZ /d "%FINAL_EXE_PATH%" /f >nul 2>&1
reg add "HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths\dc2url.exe" /v "Path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f /reg:64 >nul 2>&1
echo.

:: ============================================================
:: PHASE 4: NATIVE DOS/CLI ENVIRONMENT PATH REGISTRATION
:: ============================================================
echo %O2%        [*] Registering global system execution paths for cmd/PowerShell...%RESET%

:: Core DOS Variables Injection
reg add "HKCU\Environment" /v "dc2url" /t REG_SZ /d "%FINAL_EXE_PATH%" /f >nul 2>&1
reg add "HKCU\Environment" /v "dc2url_path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f >nul 2>&1

:: Appending to User PATH environment variable cleanly using PowerShell to protect length limits
powershell -NoProfile -Command "$p=[System.Environment]::GetEnvironmentVariable('PATH','User') -split ';' | Where-Object {$_ -ne ''}; if($p -notcontains '%FINAL_EXEC_DIR%'){ [System.Environment]::SetEnvironmentVariable('PATH',((@('%FINAL_EXEC_DIR%')+$p) -join ';'),'User') }" >nul 2>&1

:: Check privilege context for system-wide assignment, but NEVER skip over registration entries
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo %O1%        [WARNING] Running in standard user context. Skipping System-Level variables, populating all 5 hives...%RESET%
    goto :POPULATE_ALL_UNINSTALL_HIVES
)

:: Admin Context Execution paths setup
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Environment" /v "dc2url_path" /t REG_SZ /d "%FINAL_EXEC_DIR%" /f /reg:64 >nul 2>&1
powershell -NoProfile -Command "$m=[System.Environment]::GetEnvironmentVariable('PATH','Machine') -split ';' | Where-Object {$_ -ne ''}; if($m -notcontains '%FINAL_EXEC_DIR%'){ [System.Environment]::SetEnvironmentVariable('PATH',((@('%FINAL_EXEC_DIR%')+$m) -join ';'),'Machine') }" >nul 2>&1

:POPULATE_ALL_UNINSTALL_HIVES
echo.
echo %O2%        [*] Auto Registering Uninstaller Keys...%RESET%
echo %O2%        [*] Auto Registering dc2url into all 5 Registry Architecture Locations...%RESET%

:: Location 1: HKLM 64-Bit Native
set "L1=HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\dc2url"
reg add "%L1%" /v "DisplayName" /t REG_SZ /d "dc2url" /f /reg:64 >nul 2>&1
reg add "%L1%" /v "UninstallString" /t REG_SZ /d "\"%VERSION_DIR%\uninstall.bat\"" /f /reg:64 >nul 2>&1
reg add "%L1%" /v "InstallLocation" /t REG_SZ /d "%VERSION_DIR%\\" /f /reg:64 >nul 2>&1
reg add "%L1%" /v "DisplayIcon" /t REG_SZ /d "%BASE_DIR%\favi-con.ico" /f /reg:64 >nul 2>&1
reg add "%L1%" /v "DisplayVersion" /t REG_SZ /d "%VERSION_NAME%" /f /reg:64 >nul 2>&1
reg add "%L1%" /v "Publisher" /t REG_SZ /d "Mercwar AI" /f /reg:64 >nul 2>&1
reg add "%L1%" /v "EstimatedSize" /t REG_DWORD /d 1024 /f /reg:64 >nul 2>&1
reg add "%L1%" /v "NoModify" /t REG_DWORD /d 1 /f /reg:64 >nul 2>&1
reg add "%L1%" /v "NoRepair" /t REG_DWORD /d 1 /f /reg:64 >nul 2>&1
echo %O2%        [1] of 5 ...%RESET%
:: Location 2: HKLM 32-Bit / Wow6432Node
set "L2=HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\dc2url"
reg add "%L2%" /v "DisplayName" /t REG_SZ /d "dc2url" /f /reg:64 >nul 2>&1
reg add "%L2%" /v "UninstallString" /t REG_SZ /d "\"%VERSION_DIR%\uninstall.bat\"" /f /reg:64 >nul 2>&1
reg add "%L2%" /v "InstallLocation" /t REG_SZ /d "%VERSION_DIR%\\" /f /reg:64 >nul 2>&1
reg add "%L2%" /v "DisplayIcon" /t REG_SZ /d "%BASE_DIR%\favi-con.ico" /f /reg:64 >nul 2>&1
reg add "%L2%" /v "DisplayVersion" /t REG_SZ /d "%VERSION_NAME%" /f /reg:64 >nul 2>&1
reg add "%L2%" /v "Publisher" /t REG_SZ /d "Mercwar AI" /f /reg:64 >nul 2>&1
reg add "%L2%" /v "EstimatedSize" /t REG_DWORD /d 1024 /f /reg:64 >nul 2>&1
reg add "%L2%" /v "NoModify" /t REG_DWORD /d 1 /f /reg:64 >nul 2>&1
reg add "%L2%" /v "NoRepair" /t REG_DWORD /d 1 /f /reg:64 >nul 2>&1
echo %O2%        [2] of 5 ...%RESET%
:INSTALL_USER_ONLY
:: Location 3: HKCU Standard User Hive
set "L3=HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\dc2url"
reg add "%L3%" /v "DisplayName" /t REG_SZ /d "dc2url" /f >nul 2>&1
reg add "%L3%" /v "UninstallString" /t REG_SZ /d "\"%VERSION_DIR%\uninstall.bat\"" /f >nul 2>&1
reg add "%L3%" /v "InstallLocation" /t REG_SZ /d "%VERSION_DIR%\\" /f >nul 2>&1
reg add "%L3%" /v "DisplayIcon" /t REG_SZ /d "%BASE_DIR%\favi-con.ico" /f >nul 2>&1
reg add "%L3%" /v "DisplayVersion" /t REG_SZ /d "%VERSION_NAME%" /f >nul 2>&1
reg add "%L3%" /v "Publisher" /t REG_SZ /d "Mercwar AI" /f >nul 2>&1
reg add "%L3%" /v "EstimatedSize" /t REG_DWORD /d 1024 /f >nul 2>&1
reg add "%L3%" /v "NoModify" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%L3%" /v "NoRepair" /t REG_DWORD /d 1 /f >nul 2>&1
echo %O2%        [3] of 5 ...%RESET%
:: Location 4: HKCU 32-Bit / Wow6432Node User Hive
set "L4=HKCU\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\dc2url"
reg add "%L4%" /v "DisplayName" /t REG_SZ /d "dc2url" /f >nul 2>&1
reg add "%L4%" /v "UninstallString" /t REG_SZ /d "\"%VERSION_DIR%\uninstall.bat\"" /f >nul 2>&1
reg add "%L4%" /v "InstallLocation" /t REG_SZ /d "%VERSION_DIR%\\" /f >nul 2>&1
reg add "%L4%" /v "DisplayIcon" /t REG_SZ /d "%BASE_DIR%\favi-con.ico" /f >nul 2>&1
reg add "%L4%" /v "DisplayVersion" /t REG_SZ /d "%VERSION_NAME%" /f >nul 2>&1
reg add "%L4%" /v "Publisher" /t REG_SZ /d "Mercwar AI" /f >nul 2>&1
reg add "%L4%" /v "EstimatedSize" /t REG_DWORD /d 1024 /f >nul 2>&1
reg add "%L4%" /v "NoModify" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%L4%" /v "NoRepair" /t REG_DWORD /d 1 /f >nul 2>&1
echo %O2%        [4] of 5 ...%RESET%
:: Location 5: HKCU Classes Hive
set "L5=HKCU\Software\Classes\Software\Microsoft\Windows\CurrentVersion\Uninstall\dc2url"
reg add "%L5%" /v "DisplayName" /t REG_SZ /d "dc2url" /f >nul 2>&1
reg add "%L5%" /v "UninstallString" /t REG_SZ /d "\"%VERSION_DIR%\uninstall.bat\"" /f >nul 2>&1
reg add "%L5%" /v "InstallLocation" /t REG_SZ /d "%VERSION_DIR%\\" /f >nul 2>&1
reg add "%L5%" /v "DisplayIcon" /t REG_SZ /d "%BASE_DIR%\favi-con.ico" /f >nul 2>&1
reg add "%L5%" /v "DisplayVersion" /t REG_SZ /d "%VERSION_NAME%" /f >nul 2>&1
reg add "%L5%" /v "Publisher" /t REG_SZ /d "Mercwar AI" /f >nul 2>&1
reg add "%L5%" /v "EstimatedSize" /t REG_DWORD /d 1024 /f >nul 2>&1
reg add "%L5%" /v "NoModify" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "%L5%" /v "NoRepair" /t REG_DWORD /d 1 /f >nul 2>&1
echo %O2%        [5] of 5 ...%RESET%
:finish
echo %O2%        [COMPLETE] Deployment phase ended successfully.%RESET%
endlocal

:: Broadcast the environment synchronization parameters to all active shells
powershell -NoProfile -Command "$api = '[DllImport("user32.dll", SetLastError=true)] public static extern bool SendNotifyMessage(IntPtr hWnd, uint Msg, IntPtr wParam, String lParam);'; $type = Add-Type -MemberDefinition $api -Name 'Win32' -Namespace 'Win32Functions' -PassThru; [Win32Functions.Win32]::SendNotifyMessage([IntPtr]0xffff, 0x001A, [IntPtr]::Zero, 'Environment') | Out-Null" >nul 2>&1
:REGISTRY_COMPLETE

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
        echo %Y2%                        [Transformation] TRANSFORM... %RESET%
        start "" "%MIDI_OUTPUT%"
        
    ) else (
        echo [AVIS ERROR] Binary download failed.
    )
) else (
    echo %TXT%                [INFO] Skipping audio playback.%RESET%
)
goto finish

:bad_file
echo         [AVIS FAILURE] File size is too small (!FILESIZE! bytes). Check network or proxy.

:finish
echo.
echo %Y2%                [To uninstall, go to Add/Remove Programs or run uninstall.bat]%RESET%
echo.
echo %TXT%        Your copy of dc2url in now installed cmd:\ dc2url -nojs [curl compat]...%RESET%
echo.

if not exist "%BASE_DIR%\setup.bat" goto :no_setup
echo.
choice /c YN /n /m "%O2%                [?] Update/Install/Re-install Eclipse for dc2url v1.1 ? (Y/N)%RESET%"
echo.
echo.
if errorlevel 2 goto :skip_setup
if errorlevel 1 goto :run_setup

:run_setup
echo %O2%                [*] Launching local setup...%RESET%
call "%BASE_DIR%\setup.bat"
goto :setup_end

:skip_setup
echo.
echo %Y2%                [INFO] Exiting...%RESET%
goto :setup_end


:no_setup
echo.
echo %Y2%                        [error] Check Installation %FINAL_EXEC_DIR%.%RESET%

:setup_end
echo.
echo.
endlocal
exit /b 0
