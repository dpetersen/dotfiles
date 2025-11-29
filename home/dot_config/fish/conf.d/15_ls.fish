if status is-interactive
    if type -q eza
        # I'm a fan of the `--git` flag, but it's not available the deb version of
        # eza.
        alias ls="eza --long --group-directories-first"
    else
        alias ls="ls -lhG"
    end
end
