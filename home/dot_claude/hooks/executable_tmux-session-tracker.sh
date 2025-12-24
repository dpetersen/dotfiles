#!/bin/bash
# Track Claude session ID and cwd by tmux pane for fork functionality
INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id')

if [ -n "$TMUX_PANE" ] && [ "$SESSION_ID" != "null" ]; then
  MAPPING_DIR="$HOME/.claude/tmux-sessions"
  mkdir -p "$MAPPING_DIR"
  jq -n --arg id "$SESSION_ID" --arg cwd "$PWD" '{session_id: $id, cwd: $cwd}' > "$MAPPING_DIR/$TMUX_PANE"
fi

exit 0
