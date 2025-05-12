switch (uname)
    case Darwin
            # This is the default path on non-OSX, but on OSX it's stored
            # somewhere weird by default and I need it consistent for
            # homeshick.
            export JJ_CONFIG=$HOME/.config/jj/config.toml
end

jj util completion fish | source

abbr -a j "jj"

# Note: you can't call a fish alias from another one, so a little copy-paste
abbr -a jramy "jj rebase --branch \"mylocal\" --destination main"
abbr -a jfarmy "jj git fetch && jj rebase --branch \"mylocal\" --destination main && jj new main"

# Push the current change to git. Mneumonic: jj git push this
abbr -a jgpt 'jj git push --change @'
