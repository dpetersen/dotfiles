if test -d ~/.tmux/plugins/tmuxifier/bin
    set -gx PATH $PATH ~/.tmux/plugins/tmuxifier/bin
    eval (tmuxifier init - fish)
end

# Auto-start tmux for interactive graphical terminal sessions
if status is-interactive
    and not set -q TMUX
    # $TERM is "linux" on a raw TTY before starting a window manager - skip
    # there to avoid launching tmux before Hyprland and nesting everything
    and not string match -q "linux" $TERM
    # Need either X11 ($DISPLAY) or a known terminal emulator
    and test -n "$DISPLAY" -o -n "$GHOSTTY_RESOURCES_DIR"
    exec tmux
end
