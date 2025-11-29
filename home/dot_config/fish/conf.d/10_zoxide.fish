if status is-interactive
    zoxide init fish | source

    # Ctrl-j: open zoxide's interactive directory picker (fzf sorted by frecency).
    # Wraps __zoxide_zi to properly clear/restore the command line and repaint.
    function __zoxide_zi_widget
        set -l buf (commandline)
        commandline -r ''
        __zoxide_zi
        commandline -r $buf
        commandline -f repaint
    end

    bind \cj __zoxide_zi_widget
    bind -M insert \cj __zoxide_zi_widget

    # Ctrl-k: like Ctrl-j but scoped to directories under cwd.
    # You'd think this was built into zoxide, but its queries aren't very fuzzy.
    function __zoxide_zi_local_widget
        set -l buf (commandline)
        commandline -r ''
        set -l result (zoxide query --list | grep "^$(pwd)/" | fzf)
        if test -n "$result"
            cd "$result"
        end
        commandline -r $buf
        commandline -f repaint
    end

    bind \ck __zoxide_zi_local_widget
    bind -M insert \ck __zoxide_zi_local_widget
end
