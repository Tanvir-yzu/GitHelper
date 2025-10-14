@echo off
REM GitHub repository management script with modern UI and colors

:: Enable UTF-8 for box-drawing UI
chcp 65001 >nul
if %ERRORLEVEL% neq 0 (
    echo [Warning] Unable to set UTF-8 encoding. Some characters may not display correctly.
)

:: Define cmd.exe color codes
set "COLOR_RED=[31m"
set "COLOR_GREEN=[32m"
set "COLOR_YELLOW=[33m"
set "COLOR_CYAN=[36m"
set "COLOR_RESET=[0m"

:: UI icons and separators
set "ICON_OK=✔"
set "ICON_FAIL=✖"
set "ICON_WARN=⚠"
set "ICON_STEP=»"
set "SEP_LINE=────────────────────────────────────"

:menu
cls
echo.
echo ============================================
echo          Git Branch Management           
echo ============================================
echo 1. Current Git branch check
echo 2. Create a new branch
echo 3. Show all branches
echo 4. Change branch
echo 5. Branch Merging
echo 0. Exit
echo ============================================
set /p choice=Enter your choice [0-3]: 

if "%choice%"=="1" goto check_branch
if "%choice%"=="2" goto create_branch
if "%choice%"=="3" goto show_all_branches
if "%choice%"=="4" goto change_branch
if "%choice%"=="5" goto merge_branch
if "%choice%"=="0" goto exit_script

echo Invalid choice. Please select a valid option.
echo.
pause
goto menu

:check_branch
cls
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
cls
echo.
set /p branch_name=Enter the name of the new branch: 
if "%branch_name%"=="" (
    echo Error: Branch name cannot be empty.
    echo.
    pause
    goto menu
)
echo Creating branch "%branch_name%"...
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

:show_all_branches
cls
echo.
echo Listing all branches...
git branch -a
if errorlevel 1 (
    echo Error: Unable to list branches. Please check for errors.
    echo.
    pause
    goto menu
)
echo.
pause
goto menu

:change_branch
cls
echo.
set /p branch_name=Enter the name of the branch to switch to: 
if "%branch_name%"=="" (
    echo Error: Branch name cannot be empty.
    echo.
    pause
    goto menu
)
echo Switching to branch "%branch_name%"...
git checkout "%branch_name%"
if errorlevel 1 (
    echo Branch switch failed. Please check for errors.
    echo.
    pause
    goto menu
)
echo Branch "%branch_name%" switched successfully.
echo.
pause
goto menu

:merge_branch
cls
echo.
set /p branch_name=Enter the name of the branch to merge into: 
if "%branch_name%"=="" (
    echo Error: Branch name cannot be empty.
    echo.
    pause
    goto menu
)
echo Merging branch "%branch_name%"...
git merge "%branch_name%"
if errorlevel 1 (
    echo Branch merge failed. Please check for errors.
    echo.
    pause
    goto menu
)
echo Branch "%branch_name%" merged successfully.
echo.
pause
goto menu



:exit_script
cls
echo Exiting script. Goodbye!
exit /b 0