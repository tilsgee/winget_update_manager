@echo off
TITLE App Update Manager Script by Tils-Gee

echo Checking for admin rights

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    cls
    echo Sorry, but this script must be run as an administrator. to quit,
    PAUSE
    exit /B
) else (
    cls
    GOTO tilsgeemain
)

:tilsgeemain
set /p answr=Hi :D wanna see the logs while updating or not? (y/n)
IF /I "%answr%"=="y" (
    GOTO tilsgee1
) ELSE (
    GOTO tilsgee2
)

:tilsgee1
cls
echo Performing the task
winget update
winget upgrade --all --verbose --accept-package-agreements --accept-source-agreements
winget upgrade --all --include-unknown --verbose --accept-package-agreements --accept-source-agreements
cls
GOTO tilsgeeend

:tilsgee2
echo Performing the task
winget update --silent --accept-package-agreements --accept-source-agreements
winget upgrade --all --silent --accept-package-agreements --accept-source-agreements
winget upgrade --all --include-unknown --silent --accept-package-agreements --accept-source-agreements
cls
GOTO tilsgeeend

:tilsgeeend
echo Script is removing temporary files before quitting

del /Q /F /S "%LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\AICleanup\*"
del /Q /F /S "%LOCALAPPDATA%\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\TempState\WinGet\*"


cls
echo To quit the app,
PAUSE