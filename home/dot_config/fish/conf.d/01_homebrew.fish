switch (uname)
    case Darwin
        # It's critical this is early in the load order because a lot of other
        # scripts end up relying on Homebrew-installed tools.
        eval "$(/opt/homebrew/bin/brew shellenv)"

        if test -d (brew --prefix)"/share/fish/completions"
            set -p fish_complete_path (brew --prefix)/share/fish/completions
        end

        if test -d (brew --prefix)"/share/fish/vendor_completions.d"
            set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
        end

        # This means I get GNU grep and friends instead of the jank OSX versions
        set PATH "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" $PATH
end
