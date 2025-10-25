:menu
cls
echo.
:: Adjust Command Prompt window size for better readability
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
// ... existing code ...
echo %COLOR_GREEN%7.%COLOR_RESET% Upstream status (ahead/behind)
echo %COLOR_GREEN%8.%COLOR_RESET% Delete branch safely
echo %COLOR_GREEN%9.%COLOR_RESET% Stash manager
echo %COLOR_GREEN%10.%COLOR_RESET% Show changes (status + short diff)
echo %COLOR_GREEN%11.%COLOR_RESET% Recent commits (graph)
echo %COLOR_GREEN%12.%COLOR_RESET% Fetch + prune remotes
echo %COLOR_GREEN%0.%COLOR_RESET% Exit
echo %SEP_LINE%
set /p choice=%COLOR_YELLOW%Enter your choice [0-12]: %COLOR_RESET%
// ... existing code ...
if "%choice%"=="7" goto upstream_status
if "%choice%"=="8" goto delete_branch_safe
if "%choice%"=="9" goto stash_manager
if "%choice%"=="10" goto show_changes
if "%choice%"=="11" goto recent_commits
if "%choice%"=="12" goto fetch_prune
// ... existing code ...