# Presto Player Support Assistant

An AI-powered support tool that helps the Presto Player support team answer customer questions using Claude Code CLI. It has read-only access to the Presto Player codebase, documentation, and troubleshooting runbooks.

## Quick Start (Mac)

```bash
# 1. Clone this repository
git clone https://github.com/prestomade/presto-player-support.git
cd presto-player-support

# 2. Run one-time setup (installs dependencies, clones codebases)
chmod +x setup-mac.sh
./setup-mac.sh

# 3. Launch (every time)
pp-support
# or: ./launch-mac.sh
```

## Quick Start (Windows)

```powershell
# 1. Clone this repository
git clone https://github.com/prestomade/presto-player-support.git
cd presto-player-support

# 2. Run one-time setup (run PowerShell as Administrator)
.\setup-windows.ps1

# 3. Launch (every time)
# Double-click "Presto Player Support" on your Desktop
# or run: .\launch-windows.bat
```

## What It Can Do

Ask questions in plain English. Examples:

- "A customer's YouTube video isn't playing, what should I check?"
- "How do player presets work?"
- "LearnDash video progression isn't tracking, help me troubleshoot"
- "How does email collection on video play work?"
- "Customer says analytics aren't showing any visits"

### Slash Commands

| Command | Purpose |
|---------|---------|
| `/troubleshoot` | Guided step-by-step diagnosis for a customer issue |
| `/lookup-api` | Look up a specific REST API endpoint |
| `/search-docs` | Search documentation and runbooks |
| `/trace-flow` | Trace a feature's code execution flow |
| `/ask-developer` | Generate a ready-to-paste Slack message for developer escalation |

## How It Works

The assistant has read-only access to:

1. **Presto Player plugin source code** -- searches actual code for accurate answers
2. **Troubleshooting runbooks** (`wiki/`) -- curated guides for common issues
3. **Reference files** (`references/`) -- architecture, API, and playback flow docs

It **cannot** modify any files. It is completely safe to use.

## Updating

Every time you launch, the tool automatically pulls the latest code and runbooks. No manual updates needed.

## Troubleshooting the Tool Itself

| Problem | Solution |
|---------|----------|
| `claude: command not found` | Run `npm install -g @anthropic-ai/claude-code` |
| `gh: command not found` | Run `brew install gh` (Mac) or install from https://cli.github.com |
| Repos not cloning | Run `gh auth login` and authenticate |
| Old code answers | Delete `.repos/` folder and re-run setup |
