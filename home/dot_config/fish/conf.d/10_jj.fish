if status is-interactive
    jj util completion fish | source

    abbr -a j "jj"

    # Note: you can't call a fish alias from another one, so a little copy-paste
    abbr -a jramy "jj rebase --branch \"mylocal\" --destination main"
    abbr -a jfarmy "jj git fetch && jj rebase --branch \"mylocal\" --destination main && jj new main"

    # Push the current change to git. Mneumonic: jj git push this
    abbr -a jgpt 'jj git push --change @'
end
