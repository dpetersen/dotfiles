if not command -s rbenv > /dev/null
    # TODO: decide what you want to do here. I don't really care about RBENV at
    # the moment, but I sometimes do on other machines?
    #echo "rbenv: command not found. See https://github.com/rbenv/rbenv"
    #exit 1
else 
        set -l rbenv_root ''
        if test -z "$RBENV_ROOT"
            set rbenv_root "$HOME/.rbenv"
            set -x RBENV_ROOT "$HOME/.rbenv"
        else
            set rbenv_root "$RBENV_ROOT"
        end

        set -x PATH $rbenv_root/shims $PATH
        set -x RBENV_SHELL fish
        if test ! -d "$rbenv_root/shims"; or test ! -d "$rbenv_root/versions"
            command mkdir -p $rbenv_root/{shims,versions}
        end
end
