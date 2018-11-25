# Install fundle if it doesn't exist:
# https://github.com/danhper/fundle
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

# Lets you source bash scripts and have them work
fundle plugin 'edc/bass'
# gcloud + gsutil completion
fundle plugin 'aliz-ai/google-cloud-sdk-fish-completion'
# There are many options for this, but this seems like a decent one. There is a
# project you found to use cobra to generate man pages, but that won't help you
# complete resource names
fundle plugin 'danhper/fish-kubectl'

fundle init

# This is vim mode. HOWEVER, the Vim mode is lacking compared to bash and
# zsh's. For instance `df-` won't work, and others. No visual mode. I am just
# going to use Alt-v, which edits the command in $EDITOR. However, having that
# mode on conflicts with vim mode in weird ways, so the answer is to disable
# vim mode altogether. Just get used to Alt-v.
# fish_vi_key_bindings

# homeshick fish completion, make `homeshick cd` work
switch (uname)
    case Darwin
            export HOMESHICK_DIR=/usr/local/opt/homeshick
            source /usr/local/share/fish/vendor_functions.d/homeshick.fish
    case '*'
            # might not need anything, `homeshick cd` seems to work in arch
            echo "# TODO homeshick, but for non-OSX"
end

# autojump
switch (uname)
    case Darwin
            [ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
    case '*'
            echo "# TODO autojump, but for non-OSX"
end

# Cargo
# TODO this is brokkeeeeeeen
#switch (uname)
#    case Darwin
#            [ -f /usr/local/Cellar/fish/2.7.1/share/fish/completions/cargo.fish ]; and source /usr/local/Cellar/fish/2.7.1/share/fish/completions/cargo.fish
#    case '*'
#            echo "# TODO cargo, but for non-OSX"
#end

# The next line updates PATH for the Google Cloud SDK.
[ -f '/Users/dpetersen/google-cloud-sdk/path.fish.inc' ]; and source '/Users/dpetersen/google-cloud-sdk/path.fish.inc'
# The next line enables shell command completion for gcloud.
[ -f '/Users/dpetersen/google-cloud-sdk/completion.fish.inc' ]; and source '/Users/dpetersen/google-cloud-sdk/completion.fish.inc'

export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"

alias k="kubectl"
alias gs="git status"
alias gc="git checkout"
alias gcv='git commit -v'
alias gfp='git fetch origin; and git pull origin master'

alias be='bundle exec'
alias bes='bundle exec spring'

export BAT_THEME="zenburn"
alias cat=bat

if type "exa" > /dev/null
  alias ls="exa --long --git"
else
  alias ls="ls -lhG"
end

alias vim="nvim"
alias vi="nvim"

eval (direnv hook fish)

# TODO fzf

# TODO evaluate this
# Something to do with getting C-s mappable in Vim, and maybe stopping it from
# halting things altogether like this is the 1970s.
# source: http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
#stty -ixon

