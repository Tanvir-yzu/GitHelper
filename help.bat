@echo off
REM GitHub repository management script with modern UI and colors

:: Enable UTF-8 for box-drawing UI
chcp 65001 >nul
if %ERRORLEVEL% neq 0 (
    echo [Warning] Unable to set UTF-8 encoding. Some characters may not display correctly.
)

:: Define ANSI color codes for modern UI
set "COLOR_RED=[31m"
set "COLOR_GREEN=[32m"
set "COLOR_YELLOW=[33m"
set "COLOR_CYAN=[36m"
set "COLOR_RESET=[0m"

:: UI icons and separators
set "ICON_OK=[32m✔[0m"
set "ICON_FAIL=[31m✖[0m"
set "ICON_WARN=[33m⚠[0m"
set "ICON_STEP=[36m»[0m"
set "SEP_LINE=[36m────────────────────────────────────[0m"

:: Watermark text
cls
echo.
echo ============================================
echo           GitHelper - Simplify Your Git Workflow
echo ============================================
echo.

:menu
cls
echo.
:: Adjust Command Prompt window size for better readability (optional)
mode con: cols=120 lines=40
echo %SEP_LINE%
echo          %COLOR_CYAN%Git Branch Management%COLOR_RESET%
echo %SEP_LINE%
echo %COLOR_GREEN%1.%COLOR_RESET% Current Git branch check
echo %COLOR_GREEN%2.%COLOR_RESET% Create a new branch
echo %COLOR_GREEN%3.%COLOR_RESET% Show all branches
echo %COLOR_GREEN%4.%COLOR_RESET% Change branch
echo %COLOR_GREEN%5.%COLOR_RESET% Branch Merging
echo %COLOR_GREEN%6.%COLOR_RESET% Git pull rebase
echo %COLOR_GREEN%7.%COLOR_RESET% Show changes (status + short diff)
echo %COLOR_GREEN%0.%COLOR_RESET% Exit
echo %SEP_LINE%
set /p choice=%COLOR_YELLOW%Enter your choice [0-5]: %COLOR_RESET%

if "%choice%"=="1" goto check_branch
if "%choice%"=="2" goto create_branch
if "%choice%"=="3" goto show_all_branches
if "%choice%"=="4" goto change_branch
if "%choice%"=="5" goto merge_branch
if "%choice%"=="6" goto git_pull_rebase
if "%choice%"=="7" goto show_changes

if "%choice%"=="0" goto exit_script

echo Invalid choice. Please select a valid option.
echo.
pause
goto menu

:check_branch
cls
echo.
echo %SEP_LINE%
echo          %COLOR_CYAN%Git Branch Checker%COLOR_RESET%
echo %SEP_LINE%
echo %ICON_STEP% %COLOR_YELLOW%Checking the current branch...%COLOR_RESET%
for /f "delims=" %%B in ('git rev-parse --abbrev-ref HEAD') do set CURRENT_BRANCH=%%B
if defined CURRENT_BRANCH (
    echo %ICON_OK% %COLOR_GREEN% You are currently on branch: %CURRENT_BRANCH%%COLOR_RESET%
) else (
    echo %ICON_FAIL% %COLOR_RED% Error: Unable to determine the current branch.%COLOR_RESET%
)
echo %SEP_LINE%
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
echo %SEP_LINE%
echo          %COLOR_CYAN%Git Branch Listing%COLOR_RESET%
echo %SEP_LINE%
echo %ICON_STEP% %COLOR_YELLOW%Listing all branches...%COLOR_RESET%
git branch -a
if errorlevel 1 (
    echo %ICON_FAIL% %COLOR_RED%Error: Unable to list branches. Please check for errors.%COLOR_RESET%
    echo.
    pause
    goto menu
)
echo %SEP_LINE%
echo %ICON_OK% %COLOR_GREEN%Branch listing completed successfully.%COLOR_RESET%
echo.
pause
goto menu

:change_branch
cls
echo.
echo Checking current branch...
for /f "delims=" %%B in ('git rev-parse --abbrev-ref HEAD') do set CURRENT_BRANCH=%%B
if defined CURRENT_BRANCH (
    echo Current branch is: %CURRENT_BRANCH%
) else (
    echo Error: Unable to determine the current branch.
    echo.
    pause
    goto menu
)
echo.
echo Listing all available branches...
setlocal enabledelayedexpansion
set branch_count=0
for /f "delims=" %%B in ('git branch --format="%%(refname:short)"') do (
    set /a branch_count+=1
    echo %%B
)
echo Total branches available: !branch_count!
endlocal
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
echo Checking current branch...
for /f "delims=" %%B in ('git rev-parse --abbrev-ref HEAD') do set CURRENT_BRANCH=%%B
if defined CURRENT_BRANCH (
    echo You are currently on branch: %CURRENT_BRANCH%
) else (
    echo Error: Unable to determine the current branch.
    echo.
    pause
    goto menu
)
echo.
echo Listing all available branches...
setlocal enabledelayedexpansion
set branch_count=0
for /f "delims=" %%B in ('git branch --format="%%(refname:short)"') do (
    set /a branch_count+=1
    echo %%B
)
echo Total branches available: !branch_count!
endlocal
echo.
set /p branch_name=Enter the name of the branch to merge into "%CURRENT_BRANCH%": 
if "%branch_name%"=="" (
    echo Error: Branch name cannot be empty.
    echo.
    pause
    goto menu
)
echo Merging branch "%branch_name%" into "%CURRENT_BRANCH%"...
git merge "%branch_name%"
if errorlevel 1 (
    echo Branch merge failed. Please check for errors.
    echo.
    pause
    goto menu
)
echo Branch "%branch_name%" successfully merged into "%CURRENT_BRANCH%".
echo.
pause
goto menu

:git_pull_rebase
cls
echo.
echo %SEP_LINE%
echo          %COLOR_CYAN%Git Pull Rebase%COLOR_RESET%
echo %SEP_LINE%

:: Display the current branch
for /f "tokens=*" %%b in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set CURRENT_BRANCH=%%b
if not defined CURRENT_BRANCH (
    echo %ICON_FAIL% %COLOR_RED%Error: Unable to determine the current branch. Please ensure you are in a Git repository.%COLOR_RESET%
    echo.
    pause
    goto menu
)
echo %ICON_STEP% %COLOR_YELLOW%Pulling latest changes from the current branch: %CURRENT_BRANCH%%COLOR_RESET%

:: Perform git pull --rebase and show output
git pull --rebase
if errorlevel 1 (
    echo %ICON_FAIL% %COLOR_RED%Error: Unable to pull latest changes. Please check for errors.%COLOR_RESET%
    echo.
    pause
    goto menu
)

echo %ICON_OK% %COLOR_GREEN%Pull and rebase completed successfully on branch: %CURRENT_BRANCH%.%COLOR_RESET%
echo.
pause
goto menu

:show_changes
cls
echo.
echo %SEP_LINE%
echo          %COLOR_CYAN%Working Tree Changes%COLOR_RESET%
echo %SEP_LINE%

:: Verify this is a Git repository
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo %ICON_FAIL% %COLOR_RED%Not a Git repository here. Open a Git repo folder.%COLOR_RESET%
    echo.
    pause
    goto menu
)

echo %ICON_STEP% %COLOR_YELLOW%Status (porcelain):%COLOR_RESET%
git status --porcelain 2>nul

echo.
echo %ICON_STEP% %COLOR_YELLOW%Summary (diff --stat):%COLOR_RESET%
git diff --stat 2>nul

echo.
echo %ICON_STEP% %COLOR_YELLOW%Unstaged diff preview (first 50 lines):%COLOR_RESET%
powershell -NoProfile -Command "git diff --no-color | Select-Object -First 50"

echo.
pause
goto menu


:exit_script
cls
echo.
echo %SEP_LINE%
echo %COLOR_CYAN%Exiting script. Goodbye!%COLOR_RESET%
echo %SEP_LINE%

:: Show additional data before exiting
echo %COLOR_YELLOW%System Information:%COLOR_RESET%
echo %ICON_STEP% Operating System: Windows
echo %ICON_STEP% Current Directory: %CD%
echo %ICON_STEP% Git Repository Status:
git status
if errorlevel 1 (
    echo %ICON_FAIL% %COLOR_RED%Error: Unable to retrieve Git repository status.%COLOR_RESET%
) else (
    echo %ICON_OK% %COLOR_GREEN%Git repository status displayed successfully.%COLOR_RESET%
)

:: Developer Information
echo %SEP_LINE%
echo %COLOR_CYAN%Developer Information:%COLOR_RESET%
echo %ICON_STEP% Name: Tanvir
echo %ICON_STEP% Contact: 2020tanvir1971@gmail.com
echo %ICON_STEP% GitHub: https://github.com/tanvir-yzu
echo %SEP_LINE%

echo %SEP_LINE%

:play_success
powershell -NoProfile -Command "[System.Media.SoundPlayer]::new('sounds\\success.wav').PlaySync()"
goto :eof
exit /b 0