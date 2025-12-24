#!/bin/bash
# Clean up session mapping when Claude exits
if [ -n "$TMUX_PANE" ]; then
  rm -f "$HOME/.claude/tmux-sessions/$TMUX_PANE"
fi
exit 0
