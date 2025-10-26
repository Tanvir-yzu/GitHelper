
# GitHelper

## Overview
GitHelper is a Windows-friendly tool that streamlines common Git tasks through a guided, colorized Command Prompt UI. It helps you check branches, create/switch/merge, list branches, and pull with rebase — plus a clean exit summary showing system and repo info.

## Prerequisites
- Windows (`cmd.exe`)
- Git installed and available in `PATH`
- Optional: enable ANSI colors for best UI
  - Run:
    ```cmd
    REG ADD HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1
    ```
  - Restart Command Prompt

## Installation
1. Clone the repository:
   ```cmd
   git clone <repository-url>
   ```
2. Enter the folder:
   ```cmd
   cd GitHelper
   ```
3. Start the helper:
   ```cmd
   help.bat
   ```

## Features
- Modern UI with colored headers, icons, and separators
- UTF‑8 mode (`chcp 65001`) for box-drawing characters
- Menu options:
  - `1` Current Git branch check  
    Displays the current branch with a clear, colored header.
  - `2` Create a new branch  
    Prompts for a branch name, validates non-empty input, and creates the branch with error handling.
  - `3` Show all branches  
    Lists local and remote branches with a structured, colored layout.
  - `4` Change branch  
    Shows the current branch, lists and counts available branches, and checks out the selected one.
  - `5` Branch Merging  
    Shows the current branch, prompts for target branch, and merges with error handling.
  - `6` Git pull rebase  
    Detects the current branch and performs `git pull --rebase`, showing detailed output and errors.
  - `0` Exit  
    Displays system information (OS and current directory), `git status`, and developer info.

### Additional Utilities
- Show Changes (`:show_changes`)
  - Status: `git status --porcelain`
  - Summary: `git diff --stat`
  - Diff preview: shows the start of the unstaged diff (truncated for readability)

## Usage Notes
- Run `help.bat` inside a Git repository for all features to work.
- If colors/icons don’t render:
  - Enable Virtual Terminal as shown in Prerequisites.
  - Use a Unicode font like `Consolas` in Command Prompt.
- The UI resizes the Command Prompt (`mode con: cols=120 lines=40`) for readability.

## Project Structure
```
├── README.md          # Project documentation
├── help.bat           # Main helper script with UI
├── run.bat            # Additional automation script
├── sounds/
│   └── success.wav    # Success sound (optional)
└── test.py            # Test script
```

## Troubleshooting
- “Not a Git repository”: Run `help.bat` in a folder that contains a `.git` directory.
- Unicode warnings: Some terminals may not fully support UTF‑8; the script still works with basic ASCII.
- Branch operations fail: Ensure your repository is clean or stash changes before switching/merging.

## Developer
- Name: Tanvir  
- Contact: 2020tanvir1971@gmail.com  
- GitHub: https://github.com/tanvir-yzu

## License
Specify your license (e.g., MIT) here.
```
        