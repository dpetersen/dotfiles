# Install fundle if it doesn't exist:
# https://github.com/danhper/fundle
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

# Lets you source bash scripts and have them work
fundle plugin 'edc/bass'
# gcloud + gsutil completion. Google has path script support for fish, but not
# completion
fundle plugin 'aliz-ai/google-cloud-sdk-fish-completion'
# I started using 'danhper/fish-kubectl', which was pretty rough. This needs to
# be addressed in cobra and then kubectl, but it's not
fundle plugin 'evanlucas/fish-kubectl-completions'

fundle plugin 'rbenv/fish-rbenv'

fundle init

# This is vim mode. HOWEVER, the Vim mode is lacking compared to bash and
# zsh's. For instance `df-` won't work, and others. No visual mode. I am just
# going to use Alt-v, which edits the command in $EDITOR. However, having that
# mode on conflicts with vim mode in weird ways, so the answer is to disable
# vim mode altogether. Just get used to Alt-v.
# 2020 Update: still not very good. Breaks Ctrl-e and all kinds of stuff.
# fish_vi_key_bindings

switch (uname)
    case Darwin
        export HOMESHICK_DIR=/usr/local/opt/homeshick
        source /usr/local/share/fish/vendor_functions.d/homeshick.fish

        [ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
    case '*'
        [ -f /home/dpetersen/.homesick/repos/homeshick/homeshick.fish ]; and source /home/dpetersen/.homesick/repos/homeshick/homeshick.fish
        [ -f /home/dpetersen/.homesick/repos/homeshick/completions/homeshick.fish ]; and source /home/dpetersen/.homesick/repos/homeshick/completions/homeshick.fish
        [ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
        # Ctrl-j for autojump into fzf
        bind \cj "cd (cat ~/.local/share/autojump/autojump.txt | sort -nr | awk -F '\t' '{print \$NF}' | fzf +s)"
        alias fj="cd (cat ~/.local/share/autojump/autojump.txt | sort -nr | awk -F '\t' '{print \$NF}' | fzf +s)"
end

# Cargo
switch (uname)
    case Darwin
            [ -f /usr/local/Cellar/fish/2.7.1/share/fish/completions/cargo.fish ]; and source /usr/local/Cellar/fish/2.7.1/share/fish/completions/cargo.fish
    case '*'
        set PATH $PATH /home/dpetersen/.cargo/bin
end

set PATH $PATH /home/dpetersen/go/bin
# https://arslan.io/2019/08/02/why-you-should-use-a-go-module-proxy/
export GOPROXY="https://proxy.golang.org"

# The next line updates PATH for the Google Cloud SDK.
[ -f '/home/dpetersen/google-cloud-sdk/path.fish.inc' ]; and source '/home/dpetersen/google-cloud-sdk/path.fish.inc'
## The next line enables shell command completion for gcloud.
#[ -f '/home/dpetersen/google-cloud-sdk/completion.fish.inc' ]; and source '/home/dpetersen/google-cloud-sdk/completion.fish.inc'

export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"

alias startx="ssh-agent startx"

abbr -a t "terraform"

abbr -a k "kubectl"
abbr -a ko "kubectl18"
abbr -a kc "kubectx"
abbr -a kn "kubens"

abbr -a g "gcloud"

# How often do I switch contexts and namespace? Welp, often enough for Ctrl-k/n
# to be a hotkey.
bind \ck "kubectx; commandline --function repaint"
bind \cn "kubens; commandline --function repaint"

set PATH $PATH /home/dpetersen/.krew/bin
abbr -a sterne "stern -Eistio\|pgbouncer -eokcomputer"
abbr -a gs "git status"
abbr -a gc "git checkout"
abbr -a gcv 'git commit -v'
abbr -a gfp 'git fetch origin; and git pull'
abbr -a gfpt 'git fetch origin; and git pull; and git trim'

abbr -a be 'bundle exec'
abbr -a bes 'bundle exec spring'
abbr -a besr 'bundle exec spring rspec'

export BAT_THEME="zenburn"
alias cat="bat -p"
alias by="bat -p -lyaml"

if type "exa" > /dev/null
  alias ls="exa --long --git --group-directories-first"
else
  alias ls="ls -lhG"
end

alias vim="nvim"
alias vi="nvim"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

direnv hook fish | source

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

# TODO evaluate this
# Something to do with getting C-s mappable in Vim, and maybe stopping it from
# halting things altogether like this is the 1970s.
# source: http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
#stty -ixon

# This is used by coc-yaml in Neovim. This is far from perfect but generally
# keep this up-to-date with the K8s version you use most frequently, I guess.
export KUBERNETES_SCHEMA_URL="https://raw.githubusercontent.com/garethr/kubernetes-json-schema/master/v1.14.0-standalone-strict/all.json"

# Tells bspwm's keyboard shortcut thing to not use fish, which can have issues
set -U SXHKD_SHELL /usr/bin/bash

set fish_greeting

eval (gh completion fish)

source /opt/asdf-vm/asdf.fish

eval (starship init fish)
