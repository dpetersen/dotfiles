# This is vim mode. HOWEVER, the Vim mode is lacking compared to bash and
# zsh's. For instance `df-` won't work, and others. No visual mode. I am just
# going to use Alt-v, which edits the command in $EDITOR. However, having that
# mode on conflicts with vim mode in weird ways, so the answer is to disable
# vim mode altogether. Just get used to Alt-v.
# 2020 Update: still not very good. Breaks Ctrl-e and all kinds of stuff.
# 2025: Trying again after some issues. I fixed the Ctrl-e bits, so we're going
# for it. It's very un-vim-like as far as what it considers a word object, but
# better than nothing probably.

if status is-interactive
    fish_vi_key_bindings

    # Restore Ctrl-e to accept autosuggestion in insert mode (vi mode overrides it)
    bind -M insert ctrl-e accept-autosuggestion
end
