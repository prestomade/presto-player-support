#!/bin/bash

# --- Load common Node.js version managers and package managers ---
# nvm
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
# fnm
command -v fnm &>/dev/null && eval "$(fnm env)"
# volta
[ -d "$HOME/.volta" ] && export VOLTA_HOME="$HOME/.volta" && export PATH="$VOLTA_HOME/bin:$PATH"
# asdf
[ -f "$HOME/.asdf/asdf.sh" ] && . "$HOME/.asdf/asdf.sh"
# Homebrew (Apple Silicon)
[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
# Homebrew (Intel Mac)
[ -f /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)"
# Common global paths
[ -d "$HOME/.npm-global/bin" ] && export PATH="$HOME/.npm-global/bin:$PATH"
[ -d "$HOME/.yarn/bin" ] && export PATH="$HOME/.yarn/bin:$PATH"
[ -d "$HOME/.pnpm" ] && export PATH="$HOME/.pnpm:$PATH"
[ -d /usr/local/bin ] && export PATH="/usr/local/bin:$PATH"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPOS_DIR="$SCRIPT_DIR/.repos"

echo ""
echo "Presto Player Support Assistant"
echo "================================"
echo ""

mkdir -p "$REPOS_DIR"

# --- Clone or update repositories ---
clone_or_update() {
    local repo=$1
    local dir=$2
    if [ -d "$REPOS_DIR/$dir" ]; then
        echo "  Updating $dir..."
        cd "$REPOS_DIR/$dir" && git pull --ff-only 2>/dev/null || echo "  Could not update $dir (offline?)"
    else
        echo "  Cloning $repo..."
        gh repo clone "$repo" "$REPOS_DIR/$dir" -- --depth 1 2>/dev/null || echo "  Could not clone $repo (check access)"
    fi
}

# Update support repo itself
cd "$SCRIPT_DIR" && git pull --ff-only 2>/dev/null || echo "  Could not update support repo (offline?)"

# Clone/update all repos in parallel
clone_or_update "prestomade/presto-player" "presto-player" &

# Wiki
if [ -d "$REPOS_DIR/presto-player-support.wiki" ]; then
    echo "  Updating wiki..."
    cd "$REPOS_DIR/presto-player-support.wiki" && git pull --ff-only 2>/dev/null || echo "  Could not update wiki (offline?)"
else
    echo "  Cloning wiki..."
    git clone --depth 1 "https://github.com/prestomade/presto-player-support.wiki.git" "$REPOS_DIR/presto-player-support.wiki" 2>/dev/null || echo "  Wiki not available (using local wiki/ folder)"
fi &

wait
echo "Done."
echo ""

# --- Resolve claude binary ---
CLAUDE_BIN="$(command -v claude 2>/dev/null)"

if [ -z "$CLAUDE_BIN" ]; then
    SEARCH_PATHS=(
        "$NVM_DIR"/versions/node/*/bin
        "$HOME"/.volta/bin
        "$HOME"/.local/share/fnm/node-versions/*/installation/bin
        "$HOME"/.asdf/shims
        "$HOME"/.npm-global/bin
        /usr/local/bin
        /opt/homebrew/bin
    )
    for search_dir in "${SEARCH_PATHS[@]}"; do
        if [ -x "$search_dir/claude" ]; then
            CLAUDE_BIN="$search_dir/claude"
            break
        fi
    done
fi

if [ -z "$CLAUDE_BIN" ]; then
    echo ""
    echo "ERROR: 'claude' command not found."
    echo ""
    echo "Install it by running:"
    echo "  npm install -g @anthropic-ai/claude-code"
    echo ""
    echo "If you already installed it, make sure 'node' and 'npm' are in your PATH."
    echo "Then re-run this script."
    exit 1
fi

# --- Launch Claude Code ---
cd "$SCRIPT_DIR"

EXTRA_DIRS=""
[ -d "$REPOS_DIR/presto-player" ] && EXTRA_DIRS="$EXTRA_DIRS --add-dir $REPOS_DIR/presto-player"
[ -d "$REPOS_DIR/presto-player-support.wiki" ] && EXTRA_DIRS="$EXTRA_DIRS --add-dir $REPOS_DIR/presto-player-support.wiki"

eval "$CLAUDE_BIN" $EXTRA_DIRS
