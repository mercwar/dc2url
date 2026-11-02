@echo off
:: InstallShield Subsystem: Force Elevated Administrative Token Context
:: -----------------------------------------------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' neq '0' ( goto :RequestUAC ) else ( goto :ExecuteSetup )

:RequestUAC
    powershell -Command "Start-Process '%~f0' -Verb RunAs -WorkingDirectory '%~dp0'"
    exit /b

:ExecuteSetup
setlocal EnableDelayedExpansion

:: =========================================================================
:: DIRECTORY RESOLUTION MAPPING & CONFIG.JSON VERSION DISCOVERY
:: =========================================================================
set "ROOT_DIR=%~dp0"
set "CONFIG_URL=https://raw.githubusercontent.com/mercwar/dc2url/main/config.json"
set "TEMP_CONFIG=%TEMP%\dc2url_config.json"

for /f %%a in ('echo prompt $E^|cmd') do set "E=%%a"
set "RESET=%E%[0m"
set "BG_GLASS=%E%[48;2;10;10;12m"
set "O1=%E%[38;2;255;68;0m"
set "O2=%E%[38;2;255;110;0m"
set "O3=%E%[38;2;255;153;0m"
set "Y1=%E%[38;2;255;200;0m"
set "Y2=%E%[38;2;255;235;0m"
set "G2=%E%[38;2;80;235;155m"
set "TXT=%E%[38;2;240;240;240m"

cls
echo %BG_GLASS%
cls
echo.
echo. 
echo  %G2%  [Eclipse] Downloading current version, please wait..%RESET%%BG_GLASS%

if exist "%TEMP_CONFIG%" del /f /q "%TEMP_CONFIG%" >nul 2>&1
dc2url -l -dc2ws2 -s "%CONFIG_URL%" -o "%TEMP_CONFIG%"

set "VERSION_TAG=v1.1"
if exist "%TEMP_CONFIG%" (
    for /f "delims=" %%v in ('powershell -NoProfile -Command "$p = $env:TEMP + [IO.Path]::DirectorySeparatorChar + 'dc2url_config.json'; if(Test-Path $p){ $j = Get-Content $p -Raw | ConvertFrom-Json; if($j.version){ Write-Output $j.version } }" 2^>nul') do (
        set "VERSION_TAG=%%v"
    )
    del /f /q "%TEMP_CONFIG%" >nul 2>&1
)       

echo [+] Discovered Version Path Mapping: %VERSION_TAG% 

set "TARGET=%ProgramFiles%\dc2url"
set "TARGET_BASE=%TARGET%\%VERSION_TAG%"
set "FINAL_EXEC_DIR=%TARGET_BASE%\exec"
set "FINAL_EXE_PATH=%FINAL_EXEC_DIR%\eclipse.exe"

set "ZIP_URL=https://mercwar01.byethost3.com/darkcom2/downlink/eclipse/eclipse.zip"
set "MENU_URL=https://mercwar01.byethost3.com/darkcom2/downlink/eclipse/menu.json"

if not exist "%TARGET%" mkdir "%TARGET%"
if not exist "%TARGET_BASE%" mkdir "%TARGET_BASE%"
if not exist "%FINAL_EXEC_DIR%" mkdir "%FINAL_EXEC_DIR%"

cd /d "%FINAL_EXEC_DIR%"

title InstallShield (R) Setup Launcher :: Eclipse Master Deployment Engine (%VERSION_TAG%)
mode con: cols=120 lines=36

chcp 65001 >nul 2>&1
color 0E

reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

cls
echo %BG_GLASS%
cls
echo.
echo %O1%        ███████╗ ██████╗██╗    ██║██████╗ ███████╗███████╗%RESET%%BG_GLASS%
echo %O2%        ██╔════╝██╔════╝██║    ██║██╔══██╗██╔════╝██╔════╝%RESET%%BG_GLASS%
echo %O3%        █████╗  ██║     ██║    ██║██████╔╝███████╗█████╗  %RESET%%BG_GLASS%
echo %Y1%        ██╔══╝  ██║     ██║    ██║██╔═══╝ ╚════██║██╔══╝  %RESET%%BG_GLASS%
echo %Y2%        ███████╗╚██████╗███████╗██║██║     ███████║███████╗%RESET%%BG_GLASS%
echo %Y2%        ╚══════╝ ╚═════╝╚══════╝╚═╝╚═╝     ╚══════╝╚══════╝%RESET%%BG_GLASS%
echo %O2%    ====================================================================================%RESET%%BG_GLASS%
echo.
echo %O2%    ====================================================================================%RESET%%BG_GLASS%
echo %Y2%                        Eclipse Ecosystem Installer :: Version %VERSION_TAG%%RESET%%BG_GLASS%
echo %O2%    ====================================================================================%RESET%%BG_GLASS%
echo.

:: --- Ensure Full Write Permissions ---
echo %O2%    [*] Granting write permissions to target directories...%RESET%
icacls "%TARGET%" /grant Users:(OI)(CI)F /t >nul 2>&1

:: =========================================================================
:: DOWNLINK ACQUISITION VIA DC2URL WITH INTEGRITY CHECK
:: =========================================================================
echo %O2%    [*] Checking for active instances of eclipse.exe...%RESET%
taskkill /f /im eclipse.exe >nul 2>&1

echo %O2%    [*] Downloading eclipse.zip via dc2url...%RESET%
if exist "%FINAL_EXEC_DIR%\eclipse.zip" del /f /q "%FINAL_EXEC_DIR%\eclipse.zip" >nul 2>&1

dc2url -l "%ZIP_URL%" -o "%FINAL_EXEC_DIR%\eclipse.zip"

if not exist "%FINAL_EXEC_DIR%\eclipse.zip" (
    echo [!] Error: eclipse.zip failed to download entirely.
    goto :error
)

for %%I in ("%FINAL_EXEC_DIR%\eclipse.zip") do set "ZIP_SIZE=%%~zI"

echo %O2%    [*] Decompressing archive (Size: !ZIP_SIZE! bytes)...%RESET%
powershell -NoProfile -Command "try { Expand-Archive -Path '%FINAL_EXEC_DIR%\eclipse.zip' -DestinationPath '%FINAL_EXEC_DIR%' -Force } catch { Write-Error $_; exit 1 }"
if %errorlevel% neq 0 (
    echo [!] Extraction failed. Zip archive structure may be corrupt.
    goto :error
)

echo %O2%    [*] Expanding eclipse.cab setup container via extrac32...%RESET%
if exist "%FINAL_EXEC_DIR%\eclipse.cab" (
    extrac32 /Y /E "%FINAL_EXEC_DIR%\eclipse.cab" /L "%FINAL_EXEC_DIR%" >nul 2>&1
) else (
    echo [!] Warning: eclipse.cab not found in root. Searching nested directories...
    for /r "%FINAL_EXEC_DIR%" %%c in (eclipse.cab) do (
        if exist "%%c" (
            extrac32 /Y /E "%%c" /L "%FINAL_EXEC_DIR%" >nul 2>&1
        )
    )
)

:: =========================================================================
:: VERIFY & LOCATE ECLIPSE.EXE (Fallback Finder)
:: =========================================================================
if not exist "%FINAL_EXE_PATH%" (
    echo [!] Warning: eclipse.exe not found directly in root. Scanning directory tree...
    for /r "%FINAL_EXEC_DIR%" %%f in (*.exe) do (
        if /i "%%~nxf" neq "dc2url.exe" (
            echo [+] Found executable: %%f
            copy /y "%%f" "%FINAL_EXE_PATH%" >nul 2>&1
        )
    )
)

if not exist "%FINAL_EXE_PATH%" (
    echo [!] CRITICAL ERROR: eclipse.exe could not be located or extracted from CAB/ZIP!
    echo Listing contents of execution directory for diagnosis:
    dir "%FINAL_EXEC_DIR%"
    goto :error
)

if not exist "%FINAL_EXEC_DIR%\menu.json" (
    echo %O2%    [*] Acquiring menu.json via dc2url...%RESET%
    dc2url -l "%MENU_URL%" -o "%FINAL_EXEC_DIR%\menu.json"
)

:: =========================================================================
:: ICON DETECTION AND HANDLING
:: =========================================================================
if exist "%TARGET%\eclipse.ico" (
    echo %O2%    [*] Copying eclipse.ico resources into exec tree...%RESET%
    copy /y "%TARGET%\eclipse.ico" "%FINAL_EXEC_DIR%\eclipse.ico" >nul 2>&1
) else if exist "%ROOT_DIR%\eclipse.ico" (
    echo %O2%    [*] Staging eclipse.ico resources from working archive...%RESET%
    copy /y "%ROOT_DIR%\eclipse.ico" "%TARGET%\eclipse.ico" >nul 2>&1
    copy /y "%ROOT_DIR%\eclipse.ico" "%FINAL_EXEC_DIR%\eclipse.ico" >nul 2>&1
)

:: =========================================================================
:: SHORTCUT CREATION (Safe VBScript Engine Delivery)
:: =========================================================================
echo %O2%    [*] Generating Desktop and Start Menu shortcuts...%RESET%
set "VBS_SCRIPT=%TEMP%\make_eclipse_lnk.vbs"
if exist "%VBS_SCRIPT%" del /f /q "%VBS_SCRIPT%" >nul 2>&1

echo Set ws = CreateObject("WScript.Shell") > "%VBS_SCRIPT%"
echo Set fso = CreateObject("Scripting.FileSystemObject") >> "%VBS_SCRIPT%"
echo ico = "%FINAL_EXEC_DIR%\eclipse.ico" >> "%VBS_SCRIPT%"
echo If Not fso.FileExists(ico) Then ico = "%TARGET%\eclipse.ico" >> "%VBS_SCRIPT%"
echo dim d, p, lnk, startLnk >> "%VBS_SCRIPT%"
echo. >> "%VBS_SCRIPT%"
echo Rem 1. Create Desktop Shortcut >> "%VBS_SCRIPT%"
echo d = ws.SpecialFolders("Desktop") >> "%VBS_SCRIPT%"
echo If fso.FolderExists(d) Then >> "%VBS_SCRIPT%"
echo     Set lnk = ws.CreateShortcut(d ^& "\Eclipse.lnk") >> "%VBS_SCRIPT%"
echo     lnk.TargetPath = "%FINAL_EXE_PATH%" >> "%VBS_SCRIPT%"
echo     lnk.WorkingDirectory = "%FINAL_EXEC_DIR%" >> "%VBS_SCRIPT%"
echo     If fso.FileExists(ico) Then lnk.IconLocation = ico ^& ",0" >> "%VBS_SCRIPT%"
echo     lnk.Save >> "%VBS_SCRIPT%"
echo End If >> "%VBS_SCRIPT%"
echo. >> "%VBS_SCRIPT%"
echo Rem 2. Create Start Menu Programs Shortcut >> "%VBS_SCRIPT%"
echo p = ws.SpecialFolders("Programs") >> "%VBS_SCRIPT%"
echo If fso.FolderExists(p) Then >> "%VBS_SCRIPT%"
echo     Set startLnk = ws.CreateShortcut(p ^& "\Eclipse.lnk") >> "%VBS_SCRIPT%"
echo     startLnk.TargetPath = "%FINAL_EXE_PATH%" >> "%VBS_SCRIPT%"
echo     startLnk.WorkingDirectory = "%FINAL_EXEC_DIR%" >> "%VBS_SCRIPT%"
echo     If fso.FileExists(ico) Then startLnk.IconLocation = ico ^& ",0" >> "%VBS_SCRIPT%"
echo     startLnk.Save >> "%VBS_SCRIPT%"
echo End If >> "%VBS_SCRIPT%"

cscript //nologo "%VBS_SCRIPT%" >nul 2>&1
if exist "%VBS_SCRIPT%" del /f /q "%VBS_SCRIPT%" >nul 2>&1

:: =========================================================================
:: WINDOWS REGISTRATION & ADD/REMOVE PROGRAMS SEEDING
:: =========================================================================
echo %O2%    [*] Injecting uninstaller context tokens to system tree...%RESET%
for %%U in (
    "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Eclipse"
    "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Eclipse"
) do (
    reg add "%%~U" /f /v "DisplayName" /t REG_SZ /d "Eclipse" >nul 2>&1
    reg add "%%~U" /f /v "UninstallString" /t REG_SZ /d "\"%TARGET%\uninstall.bat\"" >nul 2>&1
    reg add "%%~U" /f /v "DisplayVersion" /t REG_SZ /d "%VERSION_TAG%" >nul 2>&1
    reg add "%%~U" /f /v "Publisher" /t REG_SZ /d "Mercwar AI" >nul 2>&1
    if exist "%FINAL_EXEC_DIR%\eclipse.ico" reg add "%%~U" /f /v "DisplayIcon" /t REG_SZ /d "\"%FINAL_EXEC_DIR%\eclipse.ico\"" >nul 2>&1
)

setx /M eclipse_path "%FINAL_EXEC_DIR%" >nul 2>&1

echo.
echo %Y2%    [SUCCESS] Eclipse %VERSION_TAG% successfully deployed and configured!%RESET%
echo %O2%    [*] Launching eclipse.exe...%RESET%
start "" "%FINAL_EXE_PATH%"
echo %Y2% [Eclipse] Is now running in your system icon tray.%RESET%
echo.
echo.
pause
exit /b 0

:error
echo.
echo [!] Setup encountered a fatal error during execution.
pause
exit /b 1
