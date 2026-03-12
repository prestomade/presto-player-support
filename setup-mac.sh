#!/bin/bash
set -e

echo ""
echo "======================================="
echo "  Presto Player Support Assistant Setup"
echo "======================================="
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPOS_DIR="$SCRIPT_DIR/.repos"

print_error() {
    echo ""
    echo "  ERROR: $1" >&2
    echo "  $2" >&2
    echo ""
}

# --- Check Xcode CLT ---
if ! xcode-select -p &>/dev/null; then
    echo "[1/7] Installing Xcode Command Line Tools..."
    echo "       A dialog may appear -- click 'Install' and wait for it to finish."
    xcode-select --install
    echo "       After installation completes, run this script again."
    exit 0
else
    echo "[1/7] Xcode Command Line Tools installed. ✓"
fi

# --- Check/Install Homebrew ---
if ! command -v brew &>/dev/null; then
    echo "[2/7] Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    [ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "[2/7] Homebrew already installed. ✓"
fi

# --- Check/Install Node.js ---
if ! command -v node &>/dev/null; then
    echo "[3/7] Installing Node.js..."
    brew install node
else
    echo "[3/7] Node.js already installed ($(node -v)). ✓"
fi

# --- Check/Install GitHub CLI ---
if ! command -v gh &>/dev/null; then
    echo "[4/7] Installing GitHub CLI..."
    brew install gh
else
    echo "[4/7] GitHub CLI already installed. ✓"
fi

# --- Authenticate GitHub ---
if ! gh auth status &>/dev/null 2>&1; then
    echo "[5/7] Authenticating with GitHub..."
    echo "       A browser window will open. Log in with your GitHub account."
    echo "       If you don't have access to the Presto Player repo, ask your admin."
    gh auth login --web --git-protocol https
else
    echo "[5/7] GitHub authenticated. ✓"
fi

# --- Install Claude Code CLI ---
if ! command -v claude &>/dev/null; then
    echo "[6/7] Installing Claude Code CLI..."
    npm install -g @anthropic-ai/claude-code
else
    echo "[6/7] Claude Code CLI already installed. ✓"
fi

# --- Clone repositories ---
echo "[7/7] Cloning Presto Player repository..."
mkdir -p "$REPOS_DIR"

if [ -d "$REPOS_DIR/presto-player" ]; then
    echo "       presto-player already cloned. ✓"
else
    echo "       Cloning presto-player..."
    if ! gh repo clone "prestomade/presto-player" "$REPOS_DIR/presto-player" -- --depth 1 2>/dev/null; then
        print_error "Could not clone presto-player." "Check that you have access. Ask your admin if needed."
    fi
fi

if [ ! -d "$REPOS_DIR/presto-player-support.wiki" ]; then
    echo "       Cloning wiki..."
    git clone --depth 1 "https://github.com/prestomade/presto-player-support.wiki.git" "$REPOS_DIR/presto-player-support.wiki" 2>/dev/null || echo "       Wiki not found (will use local wiki/ folder). ✓"
fi

# --- Create shell alias ---
SHELL_RC=""
[ -f "$HOME/.zshrc" ] && SHELL_RC="$HOME/.zshrc"
[ -z "$SHELL_RC" ] && [ -f "$HOME/.bashrc" ] && SHELL_RC="$HOME/.bashrc"

ALIAS_CMD="alias pp-support='$SCRIPT_DIR/launch-mac.sh'"

if [ -n "$SHELL_RC" ]; then
    if ! grep -q "pp-support" "$SHELL_RC" 2>/dev/null; then
        echo "" >> "$SHELL_RC"
        echo "# Presto Player Support Assistant" >> "$SHELL_RC"
        echo "$ALIAS_CMD" >> "$SHELL_RC"
        echo "Shell alias 'pp-support' created. ✓"
    else
        echo "Shell alias 'pp-support' already exists. ✓"
    fi
fi

echo ""
echo "======================================="
echo "  Setup Complete!"
echo "======================================="
echo ""
echo "To start the support assistant:"
echo "  1. Open a new terminal (or run: source $SHELL_RC)"
echo "  2. Type: pp-support"
echo ""
echo "Or run: ./launch-mac.sh"
echo ""
