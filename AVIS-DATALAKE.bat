@echo off
SETLOCAL EnableExtensions EnableDelayedExpansion

TITLE AVIS-2026 DATALAKE - JSON Input Stream Transmitter
color 0B

SET "TARGET_URL=https://cron.iblogger.org/AVIS-DATALAKE/avis.php"
SET "TEST_ID=GUID-{!RANDOM!!RANDOM!-!RANDOM!-!RANDOM!}"
SET "TIMESTAMP=%DATE% %TIME%"

echo ===================================================================
echo   AVIS-2026 DATALAKE - JSON STREAM TRANSMITTER
echo ===================================================================
echo Target Endpoint : %TARGET_URL%
echo GUID ID         : %TEST_ID%
echo -------------------------------------------------------------------

echo [INFO] Constructing JSON payload stream...

:: Construct the JSON payload string cleanly using variables
SET "JSON_PAYLOAD={"
SET "JSON_PAYLOAD=!JSON_PAYLOAD!\"method\":\"add\","
SET "JSON_PAYLOAD=!JSON_PAYLOAD!\"id\":\"%TEST_ID%\","
SET "JSON_PAYLOAD=!JSON_PAYLOAD!\"file\":{\"title\":\"automated_telemetry_packet\"},"
SET "JSON_PAYLOAD=!JSON_PAYLOAD!\"owner\":{\"system_id\":\"SYS-DATALAKE-ALPHA\",\"team\":\"Operations\",\"contact_email\":\"admin@mercwar.ai\"},"
SET "JSON_PAYLOAD=!JSON_PAYLOAD!\"lifecycle\":{\"version\":\"v1.0.0\"},"
SET "JSON_PAYLOAD=!JSON_PAYLOAD!\"usage\":{\"context\":\"win32_x64\",\"purpose\":\"local_tooling\",\"frequency\":\"random\",\"notes\":\"Automated ingest sync\"},"
SET "JSON_PAYLOAD=!JSON_PAYLOAD!\"home\":{\"realm\":\"AVIS-PRIMARY-CORE\",\"alpha\":\"json\",\"payload_content\":\"Operational uplink verified via JSON input stream\"}"
SET "JSON_PAYLOAD=!JSON_PAYLOAD!}"

echo [INFO] Transmitting via WebView2 headless engine with application/json header...
echo.

:: Execute dc2url sending application/json so PHP catches it via php://input
dc2url -X POST "%TARGET_URL%" ^
     -H "Content-Type: application/json" ^
     -d "!JSON_PAYLOAD!"

set "RETVAL=%ERRORLEVEL%"

echo ------------------------------------------------------------------
if %RETVAL% EQU 0 (
    echo [SUCCESS] Payload processed successfully through JSON input stream.
    pause
    EXIT /B 0
) else (
    echo [ERROR] Transmission failed with exit code %RETVAL%.
    pause
    EXIT /B %RETVAL%
)
