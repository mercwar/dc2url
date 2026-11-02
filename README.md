<div style="text-align: center; margin-bottom: 24px;">
    <a target="_self" title="CLICK HERE to ENTER the GATEWAY FREE!" href="https://mercwar.github.io/Constellation/index.html">
    <img 
        src="https://raw.githubusercontent.com/mercwar/Robo-Knight-Gallery/refs/heads/main/Version%207/image_d2a07390.png" 
        alt="Mercwar Constellation - Gateway Access" 
        style="width:100%; height:auto; border-radius:12px; box-shadow:0 6px 16px rgba(0,0,0,0.6);"
    />
    </a>
</div>


# ✨ dc2url powerd by ⚡ Dark-Com-2  

#####  DARK-COM-2 :: High-Performance  

![dc24](images/dc2url.png)

###  💥 cURL-Compatible Headless Browser Engine

💫 Instant powershell installer:  

- Open your MS windows 11 powershell
- Paste the below command in the window
- Press enter and follow the installation steps
  
😲️ Your command line now has access to your private host's php and web app cgi/uri/api  
😜️ Your command line will no longer be rejected by javascript enabled warnings you get with cURL
  
###### 🎶 *<i>TO LISTEN TO THE SURPRISE THEME SONG MIDI SELECT SOUND ON</i>!*

```bash
& ([scriptblock]::Create((irm "https://raw.githubusercontent.com/mercwar/dc2url/main/install.ps1"))) -sound "on"
```

OR

```bash
irm "https://raw.githubusercontent.com/mercwar/dc2url/main/install.ps1" | iex
```

then

```bash
dc2url -v "http://mercwar01.byethost3.com/darkcom2/echo.php"
```

This method wraps the download string into a local script block invocation (`&`) so you can append parameters directly to the tail end of the command.


##### 🌈 **Dark-Com-2** is a lightweight, high-performance command-line HTTP client and headless browser engine .

- Built on native Win32 API and pure C.
- Powered by the Microsoft Edge WebView2 Evergreen Runtime
- It bridges standard cURL CLI semantics with a full Chromium execution core
- Enabling automated telemetry, scriptable API testing 
- Persistent session management across local networks and remote hosts.

---



![dc23](./images/dc2rm.png)

###### *"<i>I am CVBGOD, and I have given it to you</i>!"*

### 🗝️ Key Features
* **Full cURL CLI Parity:** Supports standard command-line argument ordering (URL first, flags first, and long-flag formats) for seamless integration into existing shell scripts and automation workflows.
* **Persistent Session Management:** Automatically maintains cookie stores, local storage, and server session tokens (such as `PHPSESSID`) across sequential invocations via a local state profile directory.
* **Local & Remote Network Support:** Engineered to communicate effortlessly with local loopback (`localhost`, `127.0.0.1`), local network subnets, and remote production servers.
* **Asynchronous IPC Architecture:** Decoupled host executable and core DLL layout utilizing high-speed native message routing to bypass thread locks and promise serialization overhead.

---

## 📦 Redistributable Package Layout

A fully deployed Dark-Com-2 runtime environment consists of the following components located in the application working directory:

| Filename | Component Type | Description |
| --- | --- | --- |
| `darkcom2.exe` | CLI Host Executable | Parses command-line arguments, manages the Win32 message loop, and handles console I/O. |
| `DarkComHeadless.dll` | Core Engine Library | Manages WebView2 execution, document origin bindings, and asynchronous fetch routing. |
| `darkcom_browser_profile/` | Persistent Data Store | Automatically provisioned directory maintaining session cookies, cache, and browser state. |

###### *Note: The target host operating system must have the **Microsoft Edge WebView2 Evergreen Runtime** installed.*

---

![dc21](./images/ssndc.png)

## 💻 Command-Line Reference & Usage

```cmd
darkcom2.exe <url> [options] 

```
Here is how you can update your documentation to properly explain and teach users how to interpret the command-line reference manual when running `dc2url`:

---

## 📖 Understanding the CLI Reference Manual

When you run `dc2url` directly from your command prompt without arguments (or with `-h` / `--help`), it outputs the built-in reference banner. Here is a breakdown of how to read and use each section of that reference:

### 1. Primary Core Options

These are the essential flags you will use for 90% of your daily HTTP requests and API testing:

* **`-X, --request <method>`**: Explicitly defines the HTTP verb (`GET`, `POST`, `PUT`, `DELETE`). Note that if you attach a data payload with `-d`, `dc2url` automatically promotes `GET` requests to `POST`.
* **`-d, --data <data>`**: Sends a raw string or JSON payload body along with your request.
* **`-o, --output <file>`**: Bypasses printing the response to the terminal and streams raw incoming data straight to a file on disk. This is what the automated installation scripts use to pull configuration files and archives safely.
* **`-h, --help`**: Triggers the reference manual screen on demand.

### 2. Secondary Protocol Options & Advanced Switches

These flags give you granular control over headers, user agents, and internal network engines:

* **`-H, --header <header>`**: Injects custom HTTP headers into your request (e.g., `-H "Authorization: Bearer <token>"`).
* **`-A, --user-agent <agent>`**: Spoofs or overrides the default client identification string sent to the server.
* **`-s, --silent`**: Suppresses all non-error output streams for clean script automation.
* **`-v, --verbose`**: Turns on detailed diagnostic tracing, mirroring standard cURL output formatting (`>` for outbound request headers/payloads, `<` for incoming response headers).
* **`-l, --local`**: Forces the application to load `DarkComHeadless.dll` locally directly from the executable's folder.
* **`--nojs, -nojs`**: Bypasses the full WebView2 JS engine entirely, switching into a high-speed WinINet binary stub mode.
* **`--nowv2, -nowv2`**: Bypasses the WebView2 environment completely and forces a dynamic fallback to the `dc2ws2` network engine.
* **`--dc2ws2, -dc2ws2`**: Explicitly routes your request through the high-performance `dc2ws2` network engine DLL.
* **`--noscript, -noscript`**: Activates direct raw download mode via `dc2ws2`, completely bypassing JavaScript rendering and WebView2 overhead for maximum download speeds.

### Examples
Here is the expanded **Command-Reference & Usage Examples** section to integrate into the `README.md`. It breaks down every flag, teaches how to read the CLI syntax, and demonstrates real-world execution modes (standard, flags-first, long-flags, network engine switches, and file output handling):

---

## 💻 Command-Reference & Usage Examples

`dc2url` supports flexible argument ordering just like standard cURL, allowing you to place URLs first, lead with operational flags, or use long-form parameters interchangeably.

```cmd
dc2url [options] <url>

```

### 1. Standard cURL Style (URL First)

Placing the target URL immediately after the executable is the traditional cURL convention.

```cmd
dc2url http://localhost:8080/echo.php -X POST -d "{\"action\":\"test_url_first\"}" -v

```

* **How to read this command:**
* `http://localhost:8080/echo.php` — The target endpoint receiving the request.
* `-X POST` — Specifies the HTTP verb to use (`GET`, `POST`, `PUT`, `DELETE`).
* `-d "{\"action\":\"test_url_first\"}"` — Attaches a raw JSON payload body. Inner double quotes are escaped (`\"`) for standard Windows CMD execution. *(Note: Passing a data payload via `-d` automatically promotes `GET` requests to `POST` even if `-X` is omitted).*
* `-v` — Enables **verbose mode**, outputting detailed diagnostic traces (`>` for outbound request frames, `<` for incoming response headers) to `stderr`.



---

### 2. Alternative Flag-First Style

You can place your operational flags and data payloads before specifying the destination URL. This is useful when scripting automated pipelines where options are dynamically appended.

```cmd
dc2url -X POST -d "{\"action\":\"test_flags_first\"}" http://localhost:8080/echo.php --verbose

```

* **How to read this command:**
* `-X POST -d ...` — Declares the HTTP method and payload upfront before the parser encounters the target URL.
* `http://localhost:8080/echo.php` — Evaluated as the destination endpoint.
* `--verbose` — Uses the long-flag variant of `-v` to enable live wire tracing.



---

### 3. Long Flags Style

For readability in shell scripts, batch routines, or maintenance documentation, you can substitute shorthand flags with descriptive long-form options.

```cmd
dc2url --request POST --data "{\"action\":\"test_long_flags\"}" http://localhost:8080/echo.php -v

```

* **How to read this command:**
* `--request POST` — Long-form equivalent of `-X POST`.
* `--data "..."` — Long-form equivalent of `-d "..."`.
* `http://localhost:8080/echo.php -v` — Destination endpoint combined with diagnostic logging.



---

### 4. Direct File Download Output (`-o, --output`)

When fetching files, installers, or remote manifests, stream incoming bytes directly to disk instead of printing them to the terminal console:

```cmd
dc2url -l -s "https://raw.githubusercontent.com/mercwar/dc2url/main/config.json" -o "C:\TEMP\config.json"

```

* **How to read this command:**
* `-l` — Forces local DLL resolution (`DarkComHeadless.dll` / dependencies in execution directory).
* `-s` — **Silent mode**, suppressing all non-error console output streams.
* `-o "C:\TEMP\config.json"` — Directs the raw response body stream into the specified disk file.



---

### 5. Advanced Engine & Protocol Execution Modes

`dc2url` includes high-performance network fallback switches to control how requests pass through system runtime engines:

* **Bypassing JavaScript Engine for High-Speed Binary Downloads (`--nojs`):**
```cmd
dc2url --nojs -s "http://mercwar01.byethost3.com/darkcom2/downlink/eclipse/eclipse.zip" -o "eclipse.zip"

```


* *Usage:* Switches into WinINet fast binary stub mode, eliminating Chromium/WebView2 JavaScript rendering overhead for pure file downloads.


* **Routing via high-performance `dc2ws2` DLL (`--dc2ws2`):**
```cmd
dc2url --dc2ws2 -s "http://mercwar01.byethost3.com/darkcom2/downlink/eclipse/menu.json" -o "menu.json"

```


* *Usage:* Bypasses standard browser contexts and routes HTTP data acquisition through the dedicated high-performance `dc2ws2` network engine DLL.


* **Direct Raw Download Mode (`--noscript`):**
```cmd
dc2url --noscript -v "http://localhost:8080/large_payload.bin" -o "large_payload.bin"

```


* *Usage:* Disables all client-side script execution and processes network frames directly via the native network DLL layer.


* **Injecting Custom HTTP Headers (`-H`):**
```cmd
dc2url http://localhost:8080/api/status -H "Authorization: Bearer token_abc123" -H "X-Client: DarkCom2" -v

```


* *Usage:* Passes sequential custom request headers (`-H`) into the outbound HTTP header frame.

---

## 🛠️ System Requirements & Deployment


![dc22](./images/ss-dc2i.png)

* **Operating System:** Windows 10 or Windows 11 (64-bit x64 architecture).
* **Runtime Dependency:** Microsoft Edge WebView2 Evergreen Runtime.
* **Permissions:** Read/write access in the execution directory for automated profile persistence and session caching.
---

# PART I: DARK-COM-2 END-USER CLI MANUAL

## 1. Overview & Syntax

`darkcom2.exe` is a high-performance, cURL-compatible command-line HTTP client powered by an embedded Microsoft Edge WebView2 execution core. It supports standard command-line ordering, persistent session/cookie management, and custom payload injection.

```cmd
darkcom2.exe [options] <url>

```

## 2. Command-Line Flags Reference

| Short Flag | Long Flag | Description |
| --- | --- | --- |
| `-X` | `--request <method>` | Specifies the HTTP method to use (e.g., `GET`, `POST`, `PUT`, `DELETE`). Defaults to `GET` unless a payload is supplied. |
| `-d` | `--data <data>` | Supplies a raw string or JSON payload body for transmission. Providing data automatically promotes the request method to `POST`. |
| `-H` | `--header <header>` | Passes custom HTTP headers (e.g., `-H "Content-Type: application/json"`). |
| `-v` | `--verbose` | Enables detailed wire logging, mirroring standard cURL output formatting (`>` for outbound requests, `<` for inbound response headers). |

## 3. Usage Examples

**Standard cURL Style (URL First):**

```cmd
darkcom2.exe http://localhost:8080/echo.php -X POST -d "{\"action\":\"test\"}" -v

```

**Alternative Flag-First Style:**

```cmd
darkcom2.exe -X POST -d "{\"action\":\"test\"}" http://localhost:8080/echo.php --verbose

```

**Long Flags Style:**

```cmd
darkcom2.exe --request POST --data "{\"action\":\"test\"}" http://localhost:8080/echo.php -v

```

## 4. State Persistence & Local Profile

* **Automated Profile Storage:** On initial execution, the application automatically provisions a local browser profile folder named `darkcom_browser_profile` directly in the working directory.
* **Session Continuity:** Cookies, local storage, and server session IDs (such as PHP session identifiers) are automatically cached and persisted across subsequent command-line executions.

---

# PART II: REDISTRIBUTABLE SDK & DEPLOYMENT REFERENCE

## 1. Redistributable Package Layout

Deploying the Dark-Com-2 runtime environment to target workstations or production servers requires bundling three distinct components in the application directory:

1. **`darkcom2.exe`** — The primary command-line host executable.
2. **`DarkComHeadless.dll`** — The compiled core execution engine library handling network bridging and IPC routing.
3. **Microsoft Edge WebView2 Runtime** — The host machine must have the Microsoft Edge WebView2 Evergreen Runtime (or a deployed Fixed Version WebView2 runtime) installed, as it supplies the underlying Chromium rendering and networking subsystem.

## 2. Environment & Runtime Requirements

* **Operating System:** Windows 10 or Windows 11 (64-bit x64 architecture).
* **Network Permissions:** Outbound TCP access on target ports (e.g., HTTP/HTTPS traffic on standard ports or local loopback `127.0.0.1` / `localhost` ports).
* **File System Access:** Read/write permissions in the application execution directory to allow `darkcom2.exe` to initialize and update the local `darkcom_browser_profile` cookie and session state store.


## 🏅️ Installation

![dc22](./images/dc2.png)

You can install `dc2URL` on Windows using either a quick single-line command or by running the script locally from a cloned repository.

### Method 1: Quick Install (PowerShell IRM)
The fastest way to install is to copy and paste the single-line command below into an open **Command Prompt** or **PowerShell** window. This downloads and executes the deployment script directly in memory:

```cmd
powershell -Command "https://raw.githubusercontent.com/mercwar/dc2URL/main/install.ps1 | iex"
```


###
- You can always download the [launcher](https://raw.githubusercontent.com/mercwar/dc2url/refs/heads/main/launcher.bat) and double click it from your desktop  
- You can also copy it from the next section and paste it into notepad, then save the file as launcher.bat and double click the file  

---

### Method 2: Local Install (Git Clone)
If you prefer to clone the repository or manage the files manually:

1. Clone the repository to your machine:
   ```bash
   git clone https://github.com/mercwar/dc2url
   cd dc2url
   launcher.bat
   ```
2. Navigate into the version directory:
   ```bash
   cd <path/to/clone or downloaded files>/dc2url
   cd dc2url
   launcher.bat
   ```
3. Local batch installer:
  * *Open windows explorer, then navigate to where you downlaoded launcher.bat*
  * **Double-click** the ` launcher.bat` file inside the directory.

or 



Save this as launcher.bat and double click it :

```
@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1

:: ============================================================
:: SELF-ELEVATION PIPELINE (REQUIRES ADMIN FOR PROGRAM FILES)
:: ============================================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process -FilePath 'cmd.exe' -ArgumentList '/c', 'cd /d ""%~dp0"" && ""%~f0""' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

:: InstallShield Setup Configuration Properties: Title Block & Bounds
title InstallShield (R) Setup Launcher v1.1 :: dc2url Master Deployment Engine
mode con: cols=120 lines=34
color 0E

:: Force TrueColor Console Canvas Context Allocation
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

echo.
echo %O1%        ██████╗  █████╗ ██████╗ ██╗  ██╗ ██████╗ ██████╗ ███╗   ███╗██████╗ %RESET%%BG_GLASS%
echo %O2%        ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔════╝██╔═══██╗████╗ ████║╚════██╗%RESET%%BG_GLASS%
echo %O3%        ██║  ██║███████║██████╔╝█████╔╝ ██║     ██║   ██║██╔████╔██║ █████╔╝%RESET%%BG_GLASS%
echo %Y1%        ██║  ██║██╔══██║██╔══██║██╔-██╗ ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ %RESET%%BG_GLASS%
echo %Y2%        ██████╔╝██║  ██║██║  ██║██║  ██║╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗%RESET%%BG_GLASS%
echo %Y2%        ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝%RESET%%BG_GLASS%
echo %O2%    ====================================================================================%RESET%%BG_GLASS%
echo %Y2%                        dc2url Core Cyborg Ecosystem Installer%RESET%%BG_GLASS%
echo %O2%    ====================================================================================%RESET%%BG_GLASS%
echo.

:: ============================================================
:: TASKKILL RUNNING ECLIPSE INSTANCES TO PREVENT WRITE LOCKS
:: ============================================================
echo %O2%    [*] Terminating any active eclipse.exe processes...%RESET%
taskkill /f /im eclipse.exe >nul 2>&1
echo %GREEN%    [*] Eclipse processes cleared.%RESET%
echo.

:: ============================================================
:: TOOL DETECTION & SELECTION (ADDED GIT)
:: ============================================================
set "count=0"

for %%T in (dc2url python curl mshta powershell certutil cscript bitsadmin winget git) do (
    set "VALID=0"
    
    if /i "%%T"=="dc2url" (
        set "IN_PATH="
        for %%p in ("%PATH:;=" "%") do (
            if exist "%%~p\dc2url.exe" set "IN_PATH=1"
        )
        if defined IN_PATH set "VALID=1"
    ) else if /i "%%T"=="python" (
        python -c "import sys" >nul 2>&1
        if !errorlevel! equ 0 (
            set "VALID=1"
        ) else (
            py -c "import sys" >nul 2>&1
            if !errorlevel! equ 0 set "VALID=1"
        )
    ) else if /i "%%T"=="git" (
        git --version >nul 2>&1
        if !errorlevel! equ 0 set "VALID=1"
    ) else if /i "%%T"=="winget" (
        winget --version >nul 2>&1
        if !errorlevel! equ 0 set "VALID=1"
    ) else if /i "%%T"=="powershell" (
        powershell -NoProfile -Command "exit 0" >nul 2>&1
        if !errorlevel! equ 0 set "VALID=1"
    ) else if /i "%%T"=="mshta" (
        where mshta >nul 2>&1
        if !errorlevel! equ 0 set "VALID=1"
    ) else if /i "%%T"=="cscript" (
        where cscript >nul 2>&1
        if !errorlevel! equ 0 set "VALID=1"
    ) else if /i "%%T"=="bitsadmin" (
        where bitsadmin >nul 2>&1
        if !errorlevel! equ 0 set "VALID=1"
    ) else if /i "%%T"=="certutil" (
        where certutil >nul 2>&1
        if !errorlevel! equ 0 set "VALID=1"
    ) else (
        where %%T >nul 2>&1
        if !errorlevel! equ 0 set "VALID=1"
    )
    
    if "!VALID!"=="1" (
        set /a count+=1
        set "tool_!count!=%%T"
    )
)

if !count! equ 0 (
    echo %O1%    [-] No download engines found. Exiting.%RESET%
    pause
    exit /b
)

echo %O2%    [AVIS] Scanning system engines...%RESET%
echo.
for /l %%i in (1,1,!count!) do (
    echo      %GRAY%[%Y1%%%i%GRAY%]%TXT% !tool_%%i!%RESET%
)
echo.

set /p "TOOL_NUM=%Y2%    >>> SELECT ENGINE [1-!count!]: %RESET%"
if "!TOOL_NUM!"=="" (
    set "SELECTED_TOOL=curl"
) else (
    set "SELECTED_TOOL="
    for /l %%i in (1,1,!count!) do (
        if "!TOOL_NUM!"=="%%i" set "SELECTED_TOOL=!tool_%%i!"
    )
)
if "!SELECTED_TOOL!"=="" set "SELECTED_TOOL=curl"

:: ============================================================
:: DIRECTORY CONFIGURATION & WRITE PERMISSION FIX
:: ============================================================
set "DEFAULT_INSTALL=%ProgramFiles%\dc2url"
if "%DEFAULT_INSTALL%"=="" set "DEFAULT_INSTALL=%SystemDrive%\Program Files\dc2url"

echo.
echo %O2%    ------------------------------------------------------------------------------------%RESET%
echo %Y2%    [AVIS] DIRECTORY CONFIGURATION%RESET%
echo %GRAY%    Default system path: !DEFAULT_INSTALL!%RESET%
echo.

set /p "INSTALL_PATH=%Y2%    >>> ENTER FULL PATH OR PRESS ENTER FOR DEFAULT: %RESET%"
if "!INSTALL_PATH!"=="" set "INSTALL_PATH=!DEFAULT_INSTALL!"

if not exist "!INSTALL_PATH!" (
    mkdir "!INSTALL_PATH!" >nul 2>&1
)

echo %O2%    [*] Ensuring write access permissions on !INSTALL_PATH!...%RESET%
icacls "!INSTALL_PATH!" /grant Users:(OI)(CI)F /t >nul 2>&1
icacls "!INSTALL_PATH!" /grant Administrators:(OI)(CI)F /t >nul 2>&1

:: ============================================================
:: DOWNLOAD CONFIG.JSON WITH CACHE-BUSTER TO DISK
:: ============================================================
set "CONFIG_URL=https://raw.githubusercontent.com/mercwar/dc2url/refs/heads/main/config.json?v=%RANDOM%%RANDOM%"
set "CONFIG_FILE=!INSTALL_PATH!\config.json"

echo.
echo %O2%    [*] Downloading fresh config.json using !SELECTED_TOOL!...%RESET%
if exist "!CONFIG_FILE!" del /f /q "!CONFIG_FILE!" >nul 2>&1
call :download_!SELECTED_TOOL! "!CONFIG_URL!" "!CONFIG_FILE!" 2>error_config.log

if not exist "!CONFIG_FILE!" (
    echo %O1%    [-] Failed to download config.json.%RESET%
    if exist error_config.log type error_config.log
    del error_config.log >nul 2>&1
    pause
    exit /b
)
del error_config.log >nul 2>&1
echo %GREEN%    [*] config.json downloaded successfully to disk.%RESET%
:: ============================================================
:: PARSE MANIFEST & LOOP NODES FROM DISK WITH ABSOLUTE PATH LOCK
:: ============================================================
echo %O2%    [*] Parsing manifest layout from disk...%RESET%

for %%f in ("!CONFIG_FILE!") do set "ABS_CONFIG_FILE=%%~ff"

if exist error_manifest.log del /f /q error_manifest.log >nul 2>&1
if exist manifest_stream.tmp del /f /q manifest_stream.tmp >nul 2>&1

:: Extract the version field directly from the JSON into the VERSION variable before running the loops
for /f "usebackq delims=" %%v in (`powershell -NoProfile -Command "(Get-Content '!ABS_CONFIG_FILE!' | ConvertFrom-Json).version"`) do set "VERSION=%%v"

powershell -NoProfile -Command "$path = '%ABS_CONFIG_FILE%'; $jsonText = [System.IO.File]::ReadAllText($path); $cfg = $jsonText | ConvertFrom-Json; $ver = $cfg.version; $skipNode = $cfg.do_not_version; foreach ($node in $cfg.manifest_layout.psobject.properties.Name) { $noVer = ($node -eq $skipNode); foreach ($item in $cfg.manifest_layout.$node) { $src = $item.source; $tgt = if ($item.target) { $item.target } else { $src }; $remoteSub = if ($noVer) { $src } else { $ver + '/' + $src }; $localSub = if ($noVer) { $tgt } else { $ver + '\' + $tgt }; [Console]::WriteLine($node + '|' + $remoteSub + '|' + $localSub) } }" > manifest_stream.tmp 2>error_manifest.log

for /f "delims=" %%i in (manifest_stream.tmp) do (
    set "LINE=%%i"
    for /f "tokens=1,2,3 delims=|" %%a in ("!LINE!") do (
        set "NODE_NAME=%%a"
        set "REMOTE_REL=%%b"
        set "LOCAL_REL=%%c"
        
        set "FILE_URL=https://raw.githubusercontent.com/mercwar/dc2url/refs/heads/main/!REMOTE_REL!"
        set "DEST_FILE=!INSTALL_PATH!\!LOCAL_REL!"
        
        for %%p in ("!DEST_FILE!") do (
            set "TARGET_DIR=%%~dpp"
            if not exist "!TARGET_DIR!" mkdir "!TARGET_DIR!" >nul 2>&1
        )
        
        echo      %GRAY%[NODE: !NODE_NAME!]%TXT% Downloading !REMOTE_REL! ...%RESET%
        call :download_!SELECTED_TOOL! "!FILE_URL!" "!DEST_FILE!" 2>error_download.log
        del error_download.log >nul 2>&1
    )
)

del manifest_stream.tmp >nul 2>&1
del error_manifest.log >nul 2>&1

echo.
echo %GREEN%    [*] Processing completed to destination target path: !INSTALL_PATH!%RESET%

:: ============================================================
:: POST-DOWNLOAD AUTOMATIC EXECUTION OF INSTALL.BAT
:: ============================================================
set "EXPECTED_INSTALL_BAT=!INSTALL_PATH!\!VERSION!\install.bat"

echo.
echo %GREEN%    [*] Target Path: !INSTALL_PATH!%RESET%
echo %GREEN%    [*] Script Path: !EXPECTED_INSTALL_BAT!%RESET%
echo %O2%    [*] Validating installer ...%RESET%

if exist "!EXPECTED_INSTALL_BAT!" (
    echo %GREEN%    [*] Success: Running dc2url installer...%RESET%
    echo.
    call "!EXPECTED_INSTALL_BAT!"
	
) else (
    echo %O1%    [-] Warning: install.bat could not be verified at expected location.%RESET%
)

goto :finish


:: ============================================================
:: INDIVIDUAL TOOL DOWNLOAD FUNCTIONS (FIXED)
:: ============================================================
:download_dc2url
if exist "%~2" del /f /q "%~2" >nul 2>&1
dc2url -dc2ws2 "%~1" -o "%~2" >nul 2>&1
goto :eof

:download_python
if exist "%~2" del /f /q "%~2" >nul 2>&1
python -c "import urllib.request; urllib.request.urlretrieve(r'%~1', r'%~2')" >nul 2>&1
if not exist "%~2" (
    py -c "import urllib.request; urllib.request.urlretrieve(r'%~1', r'%~2')" >nul 2>&1
)
goto :eof

:download_git
if exist "%~2" del /f /q "%~2" >nul 2>&1
powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%~1' -OutFile '%~2' -UseBasicParsing"
goto :eof

:download_curl
if exist "%~2" del /f /q "%~2" >nul 2>&1
curl -s -S -L -f --connect-timeout 15 --retry 2 -o "%~2" "%~1"
goto :eof

:download_mshta
if exist "%~2" del /f /q "%~2" >nul 2>&1
mshta "javascript:try{var x=new ActiveXObject('MSXML2.ServerXMLHTTP.6.0');x.open('GET','%~1',false);x.send();if(x.status==200){var s=new ActiveXObject('ADODB.Stream');s.Type=1;s.Open();s.Write(x.ResponseBody);s.SaveToFile('%~2',2);s.Close();}}catch(e){}close();" >nul 2>&1
if not exist "%~2" (
    powershell -NoProfile -Command "Invoke-WebRequest -Uri '%~1' -OutFile '%~2' -UseBasicParsing" >nul 2>&1
)
goto :eof


:download_powershell
if exist "%~2" del /f /q "%~2" >nul 2>&1
powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%~1' -OutFile '%~2' -UseBasicParsing"
goto :eof

:download_certutil
if exist "%~2" del /f /q "%~2" >nul 2>&1
certutil -urlcache -split -f "%~1" "%~2" >nul 2>&1
certutil -urlcache -f "%~1" delete >nul 2>&1
if not exist "%~2" (
    powershell -NoProfile -Command "Invoke-WebRequest -Uri '%~1' -OutFile '%~2' -UseBasicParsing" >nul 2>&1
)
goto :eof

:download_cscript
if exist "%~2" del /f /q "%~2" >nul 2>&1

:: Pure silent execution via inline PowerShell. No temporary files created on disk.
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;" ^
    "$w = New-Object System.Net.WebClient;" ^
    "$w.Timeout = 15000;" ^
    "try { $w.DownloadFile('%~1', '%~2'); } catch {}" >nul 2>&1

goto :eof



:download_bitsadmin
if exist "%~2" del /f /q "%~2" >nul 2>&1
bitsadmin /transfer "dc2url_job_%RANDOM%" /download /priority foreground "%~1" "%~2" >nul 2>&1
if not exist "%~2" (
    powershell -NoProfile -Command "Invoke-WebRequest -Uri '%~1' -OutFile '%~2' -UseBasicParsing" >nul 2>&1
)
goto :eof

:download_winget
if exist "%~2" del /f /q "%~2" >nul 2>&1
powershell -NoProfile -Command "Invoke-WebRequest -Uri '%~1' -OutFile '%~2' -UseBasicParsing"
goto :eof
```
   

#### Folders and files


```
 
mercwar/dc2URL/
    ├── launcher.bat     <-- Installation Downloader (copy and paste compatable)
    ├── install.ps1      <-- IRM - Net Installer (Windows 11 home PowerShell or Higher)
    ├── echo.bat         <-- Validation Utility (local and private host)
    ├── favi-con.ico     <-- Root Icon Asset
    ├── readme.MD        <-- User and Developer Reference
    └── v1.0/
        ├── install.bat      <-- Windows 11 Installer  (Root level)
        ├── uninstall.bat    <-- Windows 11 Uninstaller (Root level)
            ├── exec/            <-- Executable Binaries Subfolder
            │   ├── darkcom2.exe
            │   ├── DarkComHeadless.dll
            │   └── WebView2Loader.dll
    ├── images/          <-- Documentation Graphics Subfolder
       ├── cmd-src.png
       ├── dc2.png
       ├── dc2rm.png
       ├── dc2url.png
       └── ss-dc2i.png

```

---

## ⚖️ Legal, License & Copyright (CR)

**Copyright © 2026 Joseph Michael Catalano Mercwar AI. All Rights Reserved.**

### 📄 Licensing Terms
This software, protocol architecture, and its associated documentation are proprietary works. Unauthorized copying, distribution, modification, or commercial exploitation of the source binaries (`dc2url.exe`, DLL libraries) or deployment scripts (`launcher.bat`, ,`install.bat`,`uninstall.bat`) without express written consent from the author is strictly prohibited.

### 🛡️ Disclaimer of Warranty
The software is provided **"as is", without warranty of any kind**, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.

### 🌐 Trademarks & Branding
* **DARKCOM2**, **dc2URL**, and the **Fire-Gem** visual aesthetic framework are trademarks of Robo Rook Universe. 
* All third-party trademarks, logos, and brand names (including Microsoft, Windows, Edge, WebView2, and GitHub) are the property of their respective owners and are used here strictly for identification and interoperability reference purposes.
