# Install fundle if it doesn't exist:
# https://github.com/danhper/fundle
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

# Lets you source bash scripts and have them work
fundle plugin 'edc/bass'
# gcloud + gsutil completion. Google has path script support for fish, but not
# completion
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

switch (uname)
    case Darwin
        export HOMESHICK_DIR=/usr/local/opt/homeshick
        source /usr/local/share/fish/vendor_functions.d/homeshick.fish

        [ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
    case '*'
        [ -f /home/dpetersen/.homesick/repos/homeshick/homeshick.fish ]; and source /home/dpetersen/.homesick/repos/homeshick/homeshick.fish
        [ -f /home/dpetersen/.homesick/repos/homeshick/completions/homeshick.fish ]; and source /home/dpetersen/.homesick/repos/homeshick/completions/homeshick.fish
end

# Cargo
switch (uname)
    case Darwin
            [ -f /usr/local/Cellar/fish/2.7.1/share/fish/completions/cargo.fish ]; and source /usr/local/Cellar/fish/2.7.1/share/fish/completions/cargo.fish
    case '*'
        set PATH $PATH /home/dpetersen/.cargo/bin
end

# The next line updates PATH for the Google Cloud SDK.
[ -f '/home/dpetersen/google-cloud-sdk/path.fish.inc' ]; and source '/home/dpetersen/google-cloud-sdk/path.fish.inc'
## The next line enables shell command completion for gcloud.
#[ -f '/home/dpetersen/google-cloud-sdk/completion.fish.inc' ]; and source '/home/dpetersen/google-cloud-sdk/completion.fish.inc'

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
  alias ls="exa --long --git --group-directories-first"
else
  alias ls="ls -lhG"
end

alias vim="nvim"
alias vi="nvim"

eval (direnv hook fish)

function fish_prompt --description 'Write out the prompt'
  set -l color_cwd
  set -l suffix
  switch "$USER"
    case root toor
      if set -q fish_color_cwd_root
        set color_cwd $fish_color_cwd_root
      else
        set color_cwd $fish_color_cwd
      end
      set suffix '#'
    case '*'
      set color_cwd $fish_color_cwd
      set suffix '>'
  end

  # this might be cleaner: https://wiki.archlinux.org/index.php/fish#Put_git_status_in_prompt
  set -l git_branch (git branch ^/dev/null | sed -n '/\* /s///p')

  echo -n -s "$USER" ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) "$git_branch" "$suffix "
end

# TODO fzf

# TODO evaluate this
# Something to do with getting C-s mappable in Vim, and maybe stopping it from
# halting things altogether like this is the 1970s.
# source: http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
#stty -ixon
