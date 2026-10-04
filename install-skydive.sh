#!/bin/bash
# claude-blog installer for pstack-skydive org — installs the blog skill suite + Python deps into this agent's sandbox
set -e
SKILLS_DST="$HOME/.pi/agent/skills"
REPO_DIR="$HOME/workspace/claude-blog"
mkdir -p "$SKILLS_DST"
[ -d "$REPO_DIR" ] || git clone --depth 1 --filter=blob:none https://github.com/samuelpullen15-droid/claude-blog "$REPO_DIR"
cd "$REPO_DIR"
# skills/ has the 32 SKILL.md dirs; agents/ has 5 subagent personas
cp -r skills/* "$SKILLS_DST/"
mkdir -p "$HOME/.pi/agent/agents" 2>/dev/null && cp -r agents/* "$HOME/.pi/agent/agents/" 2>/dev/null || true
# Python deps for quality scoring
pip3 install --break-system-packages --quiet -r requirements.txt 2>/dev/null || pip3 install --break-system-packages --quiet textstat beautifulsoup4 2>/dev/null || echo "WARN: install Python deps manually: pip3 install --break-system-packages textstat beautifulsoup4"
echo "claude-blog installed: 32 blog skills + 5 agents"
