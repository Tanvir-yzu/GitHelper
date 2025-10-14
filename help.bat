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

:menu
cls
echo.
echo %SEP_LINE%
echo          %COLOR_CYAN%Git Branch Management%COLOR_RESET%
echo %SEP_LINE%
echo %COLOR_GREEN%1.%COLOR_RESET% Current Git branch check
echo %COLOR_GREEN%2.%COLOR_RESET% Create a new branch
echo %COLOR_GREEN%3.%COLOR_RESET% Show all branches
echo %COLOR_GREEN%4.%COLOR_RESET% Change branch
echo %COLOR_GREEN%5.%COLOR_RESET% Branch Merging
echo %COLOR_GREEN%0.%COLOR_RESET% Exit
echo %SEP_LINE%
set /p choice=%COLOR_YELLOW%Enter your choice [0-5]: %COLOR_RESET%

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



:exit_script
cls
echo.
echo %SEP_LINE%
echo %COLOR_CYAN%Exiting script. Goodbye!%COLOR_RESET%
echo %SEP_LINE%
exit /b 0