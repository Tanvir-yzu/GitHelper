@echo off
REM GitHub repository management script with menu options

:: Enable UTF-8 for box-drawing UI
chcp 65001 >nul
if %ERRORLEVEL% neq 0 (
    echo Warning: Unable to set UTF-8 encoding. Some characters may not display correctly.
)

:menu
echo ============================================
echo Git Branch Management
echo ============================================
echo 1. Current Git branch check
echo 2. Create a new branch
echo 3. Exit
echo ============================================
set /p choice=Enter your choice [1-3]: 

if "%choice%"=="1" goto check_branch
if "%choice%"=="2" goto create_branch
if "%choice%"=="3" goto exit_script

echo Invalid choice. Please select a valid option.
echo.
goto menu

:check_branch
echo.
echo Checking current branch...
for /f "delims=" %%B in ('git rev-parse --abbrev-ref HEAD') do set CURRENT_BRANCH=%%B
if defined CURRENT_BRANCH (
    echo Current branch is: %CURRENT_BRANCH%
) else (
    echo Error: Unable to determine the current branch.
)
echo.
pause
goto menu

:create_branch
echo.
set /p branch_name=Enter the name of the new branch: 
if "%branch_name%"=="" (
    echo Error: Branch name cannot be empty.
    echo.
    pause
    goto menu
)
git branch "%branch_name%"
if errorlevel 1 (
    echo Branch creation failed. Please check for errors.
    echo.
    pause
    goto menu
)
echo Branch "%branch_name%" created successfully.
echo.
pause
goto menu

:exit_script
echo Exiting script. Goodbye!
exit /b 0