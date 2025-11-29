# This is vim mode. HOWEVER, the Vim mode is lacking compared to bash and
# zsh's. For instance `df-` won't work, and others. No visual mode. I am just
# going to use Alt-v, which edits the command in $EDITOR. However, having that
# mode on conflicts with vim mode in weird ways, so the answer is to disable
# vim mode altogether. Just get used to Alt-v.
# 2020 Update: still not very good. Breaks Ctrl-e and all kinds of stuff.
# 2025: We're trying it again! Or at least we would but it's failing with:
#
#     There is no fish_key_bindings function called: 'fish_vi_key_bindings'
#
# fish_vi_key_bindings
