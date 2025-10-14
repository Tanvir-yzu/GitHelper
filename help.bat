@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: Enable UTF-8 for box-drawing UI
chcp 65001 >nul

:: Check if Git is installed and available
where git >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Git is not installed or not in PATH.
    pause
    endlocal
    exit /b 1
)

:: Check if current directory is a Git repository
git rev-parse --is-inside-work-tree >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Not a Git repository (or any of the parent directories).
    pause
    endlocal
    exit /b 1
)

:: Get current branch name
for /f "delims=" %%i in ('git branch --show-current 2^>nul') do set "current_branch=%%i"

if defined current_branch (
    echo Current branch: !current_branch!
) else (
    echo Not on any branch (detached HEAD state)
)

:: Get all local branches
echo.
echo Available local branches:
echo ------------------------
for /f "delims=" %%i in ('git branch 2^>nul') do (
    set "branch=%%i"
    set "branch=!branch:~2!"
    if "!branch!"=="%current_branch%" (
        echo [*] !branch!
    ) else (
        echo [ ] !branch!
    )
)

pause

endlocal
exit /b 0