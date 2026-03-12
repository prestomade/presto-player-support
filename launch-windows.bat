@echo off
title Presto Player Support Assistant

echo.
echo Presto Player Support Assistant
echo ================================
echo.

set SCRIPT_DIR=%~dp0
set REPOS_DIR=%SCRIPT_DIR%.repos

if not exist "%REPOS_DIR%" mkdir "%REPOS_DIR%"

:: --- Auto-update or clone repositories ---
echo Syncing repositories...

cd /d "%SCRIPT_DIR%"
git pull --ff-only 2>nul || echo   Could not update support repo (offline?)

if exist "%REPOS_DIR%\presto-player" (
    echo   Updating presto-player...
    cd /d "%REPOS_DIR%\presto-player" && git pull --ff-only 2>nul || echo   Could not update presto-player
) else (
    echo   Cloning presto-player...
    gh repo clone prestomade/presto-player "%REPOS_DIR%\presto-player" -- --depth 1 2>nul || echo   Could not clone presto-player
)

if exist "%REPOS_DIR%\presto-player-support.wiki" (
    echo   Updating wiki...
    cd /d "%REPOS_DIR%\presto-player-support.wiki" && git pull --ff-only 2>nul || echo   Could not update wiki
) else (
    echo   Cloning wiki...
    git clone --depth 1 "https://github.com/prestomade/presto-player-support.wiki.git" "%REPOS_DIR%\presto-player-support.wiki" 2>nul || echo   Wiki not available
)

echo Done.
echo.

:: --- Launch Claude Code ---
cd /d "%SCRIPT_DIR%"

set EXTRA_DIRS=
if exist "%REPOS_DIR%\presto-player" set EXTRA_DIRS=%EXTRA_DIRS% --add-dir "%REPOS_DIR%\presto-player"
if exist "%REPOS_DIR%\presto-player-support.wiki" set EXTRA_DIRS=%EXTRA_DIRS% --add-dir "%REPOS_DIR%\presto-player-support.wiki"

claude %EXTRA_DIRS%
