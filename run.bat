@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: Enable UTF-8 for box-drawing UI
chcp 65001 >nul

:: Color palette (works best in Windows Terminal)
set "COLOR_RED=[31m"
set "COLOR_GREEN=[32m"
set "COLOR_YELLOW=[33m"
set "COLOR_CYAN=[36m"
set "COLOR_RESET=[0m"

set "ICON_OK=✔"
set "ICON_FAIL=✖"
set "ICON_WARN=⚠"
set "ICON_STEP=»"
set "SEP_LINE=────────────────────────────────────"
set "HACKER_MODE=1"

if "%HACKER_MODE%"=="1" (
    echo %COLOR_GREEN%╔%SEP_LINE%╗%COLOR_RESET%
    echo %COLOR_GREEN%║%COLOR_RESET%  %COLOR_GREEN%H4CK3R // G1T H3LP3R%COLOR_RESET%           %COLOR_GREEN%║%COLOR_RESET%
    echo %COLOR_GREEN%╚%SEP_LINE%╝%COLOR_RESET%
    for /l %%i in (1,1,5) do echo %COLOR_GREEN%[INIT] 0x!random!!random!!random!%COLOR_RESET%
) else (
    echo %COLOR_CYAN%┌%SEP_LINE%┐%COLOR_RESET%
    echo %COLOR_CYAN%│%COLOR_RESET%  %COLOR_GREEN%Simple Git Script%COLOR_RESET%                 %COLOR_CYAN%│%COLOR_RESET% 
    echo %COLOR_CYAN%└%SEP_LINE%┘%COLOR_RESET%
)
echo.

:: Ensure Git is available
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_STEP% SCAN :: Git%COLOR_RESET%) else (echo %COLOR_CYAN%%ICON_STEP% Checking Git availability...%COLOR_RESET%)
where git >nul 2>&1
if errorlevel 1 (
    echo %COLOR_RED%%ICON_FAIL% Git is not installed or not available in PATH.%COLOR_RESET%
    endlocal & exit /b 1
)
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_OK%  Git ready.%COLOR_RESET%) else (echo %COLOR_GREEN%%ICON_OK%  Git is available.%COLOR_RESET%)
echo.

:: Ensure we are inside a Git repository (initialize if missing)
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_STEP%  REPO :: Inspect%COLOR_RESET%) else (echo %COLOR_CYAN%%ICON_STEP%  Checking repository...%COLOR_RESET%)
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
if "%HACKER_MODE%"=="1" (echo %COLOR_YELLOW%%ICON_WARN%  REPO :: Init%COLOR_RESET%) else (echo %COLOR_YELLOW%%ICON_WARN%  No Git repository detected. Initializing...%COLOR_RESET%)
    git init
    if errorlevel 1 (
        echo %COLOR_RED%%ICON_FAIL%  Failed to initialize git repository.%COLOR_RESET%
        endlocal & exit /b 1
    )
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_OK%  REPO :: Ready%COLOR_RESET%) else (echo %COLOR_GREEN%%ICON_OK%  Repository initialized.%COLOR_RESET%)
) else (
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_OK%  REPO :: OK%COLOR_RESET%) else (echo %COLOR_GREEN%%ICON_OK%  Repository OK.%COLOR_RESET%)
)
echo.

:: Check for changes
set "hasChanges="
for /f "delims=" %%s in ('git status --porcelain') do set hasChanges=1

if not defined hasChanges (
    if "%HACKER_MODE%"=="1" (echo %COLOR_YELLOW%%ICON_WARN%  DIFF :: None%COLOR_RESET%) else (echo %COLOR_YELLOW%%ICON_WARN%  No changes detected. Skipping add/commit.%COLOR_RESET%)
    goto push_section
)

if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_STEP%  STAGE :: All%COLOR_RESET%) else (echo %COLOR_CYAN%%ICON_STEP%  Staging changes...%COLOR_RESET%)
:: Stage all changes
git add -A
if errorlevel 1 (
    if "%HACKER_MODE%"=="1" (echo %COLOR_RED%%ICON_FAIL%  STAGE :: Fail%COLOR_RESET%) else (echo %COLOR_RED%%ICON_FAIL%  git add failed.%COLOR_RESET%)
    endlocal & exit /b 1
)
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_OK%  STAGE :: OK%COLOR_RESET%) else (echo %COLOR_GREEN%%ICON_OK%  Staged.%COLOR_RESET%)
echo.

:: Prompt for commit message (sanitize quotes and trim)
if "%HACKER_MODE%"=="1" (set /p commit_text=%COLOR_GREEN%%ICON_STEP% MSG :: %COLOR_RESET%) else (set /p commit_text=%COLOR_YELLOW%%ICON_STEP% Enter the git commit message: %COLOR_RESET%)
set "commit_text=%commit_text:"=%"
for /f "tokens=* delims= " %%A in ("%commit_text%") do set "commit_text=%%A"

:: Decide final commit message
if "%commit_text%"=="" (
    if "%HACKER_MODE%"=="1" (set "commit_msg=HACKER AUTO COMMIT") else (set "commit_msg=Auto commit")
) else (
    set "commit_msg=%commit_text%"
)

:: Commit outside of IF to avoid parser issues
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_STEP%  COMMIT :: Write%COLOR_RESET%) else (echo %COLOR_CYAN%%ICON_STEP%  Committing...%COLOR_RESET%)
git commit -m "%commit_msg%"
if errorlevel 1 (
    if "%HACKER_MODE%"=="1" (echo %COLOR_RED%%ICON_FAIL%  COMMIT :: Fail%COLOR_RESET%) else (echo %COLOR_RED%%ICON_FAIL%  Commit failed.%COLOR_RESET%)
    endlocal & exit /b 1
)
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_OK%  COMMIT :: %commit_msg%%COLOR_RESET%) else (echo %COLOR_GREEN%%ICON_OK%  Committed with message: %commit_msg%%COLOR_RESET%)
echo.

:push_section

:: Get the current branch name and add it to the commit message
for /f "delims=" %%B in ('git rev-parse --abbrev-ref HEAD') do set CURRENT_BRANCH=%%B

:: Display the current branch name with design
echo.
if "%HACKER_MODE%"=="1" (
    echo %COLOR_GREEN%╔%SEP_LINE%╗%COLOR_RESET%
    echo %COLOR_GREEN%║%COLOR_RESET%  %COLOR_GREEN%BRANCH :: %COLOR_YELLOW%[ %CURRENT_BRANCH% ]%COLOR_RESET%      %COLOR_GREEN%║%COLOR_RESET%
    echo %COLOR_GREEN%╚%SEP_LINE%╝%COLOR_RESET%
) else (
    echo %COLOR_CYAN%┌%SEP_LINE%┐%COLOR_RESET%
    echo %COLOR_CYAN%│%COLOR_RESET%  %COLOR_GREEN%Current Git Branch:%COLOR_RESET%             %COLOR_CYAN%│%COLOR_RESET%
    echo %COLOR_CYAN%│%COLOR_RESET%      %COLOR_YELLOW%[ %CURRENT_BRANCH% ]%COLOR_RESET%              %COLOR_CYAN%│%COLOR_RESET%
    echo %COLOR_CYAN%└%SEP_LINE%┘%COLOR_RESET%
)
echo.
:: Determine branch to push
if "%HACKER_MODE%"=="1" (set /p branch_input=%COLOR_GREEN%%ICON_STEP% PUSH :: Branch [%CURRENT_BRANCH%] > %COLOR_RESET%) else (set /p branch_input=%COLOR_YELLOW%%ICON_STEP% Enter the branch to push (Current Branch -  %CURRENT_BRANCH%): %COLOR_RESET%)
set "branch_name=%branch_input%"
if "%branch_name%"=="" (
    for /f "delims=" %%b in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set "branch_name=%%b"
    if "%branch_name%"=="" set "branch_name=%CURRENT_BRANCH%"
)

:: Ensure remote 'origin' exists
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_STEP%  REMOTE :: origin%COLOR_RESET%) else (echo %COLOR_CYAN%%ICON_STEP%  Checking remote 'origin'...%COLOR_RESET%)
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    if "%HACKER_MODE%"=="1" (
        echo %COLOR_RED%%ICON_FAIL% REMOTE :: Missing%COLOR_RESET%
        echo %COLOR_GREEN%HINT :: git remote add origin https://github.com/<user>/<repo>.git%COLOR_RESET%
    ) else (
        echo %COLOR_RED%%ICON_FAIL% Remote 'origin' is not configured.%COLOR_RESET%
        echo %COLOR_CYAN%Add it with: git remote add origin https://github.com/<your-username>/<your-repo>.git%COLOR_RESET%
    )
    endlocal & exit /b 1
)
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_OK%  REMOTE :: OK%COLOR_RESET%) else (echo %COLOR_GREEN%%ICON_OK%  Remote 'origin' detected.%COLOR_RESET%)
echo.

:: Push to origin
if "%HACKER_MODE%"=="1" (echo %COLOR_GREEN%%ICON_STEP% PUSH :: origin/%branch_name%%COLOR_RESET%) else (echo %COLOR_CYAN%%ICON_STEP% Pushing to origin/%branch_name%...%COLOR_RESET%)
git push origin "%branch_name%"
if errorlevel 1 (
    if "%HACKER_MODE%"=="1" (echo %COLOR_RED%%ICON_FAIL% PUSH :: Fail%COLOR_RESET%) else (echo %COLOR_RED%%ICON_FAIL% Push failed.%COLOR_RESET%)
    endlocal & exit /b 1
)

if "%HACKER_MODE%"=="1" (
    echo %COLOR_GREEN%%ICON_OK%  STATUS :: COMPLETE%COLOR_RESET%
    echo %COLOR_GREEN%╔%SEP_LINE%╗%COLOR_RESET%
    echo %COLOR_GREEN%║%COLOR_RESET%  %COLOR_GREEN%OP :: SUCCESS%COLOR_RESET%                   %COLOR_GREEN%║%COLOR_RESET%
    echo %COLOR_GREEN%╚%SEP_LINE%╝%COLOR_RESET%
) else (
    echo %COLOR_GREEN%%ICON_OK%  Done.%COLOR_RESET%
    echo %COLOR_CYAN%┌%SEP_LINE%┐%COLOR_RESET%
    echo %COLOR_CYAN%│%COLOR_RESET%  %COLOR_GREEN%✔     Completed%COLOR_RESET%                   %COLOR_CYAN%│%COLOR_RESET%
    echo %COLOR_CYAN%└%SEP_LINE%┘%COLOR_RESET%
)

powershell -NoProfile -Command "(New-Object Media.SoundPlayer '%~dp0sounds\success.wav').PlaySync()" >nul 2>&1

endlocal
exit /b