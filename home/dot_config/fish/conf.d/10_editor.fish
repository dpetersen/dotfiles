# User scripts
fish_add_path -g ~/.local/bin

# Use minimal nvim config for quick editor sessions (commit messages, Alt-v, etc.)
set -gx EDITOR "nvim-minimal"
set -gx VISUAL "nvim-minimal"
# TODO: Investigate if Catppuccin theme is available for bat
set -gx BAT_THEME "zenburn"

if status is-interactive
    abbr -a vim 'nvim'
    abbr -a n 'nvim'
    alias cat="bat -p"
    alias by="bat -p -lyaml"
end
