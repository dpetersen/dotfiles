# Provide macOS-style clipboard commands on Linux
if is_linux; and status is-interactive
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
end
