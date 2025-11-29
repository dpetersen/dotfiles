set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
# TODO: Investigate if Catppuccin theme is available for bat
set -gx BAT_THEME "zenburn"

if status is-interactive
    abbr -a vim 'nvim'
    abbr -a n 'nvim'
    alias cat="bat -p"
    alias by="bat -p -lyaml"
end
