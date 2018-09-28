# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# See the README in that dir for the reasoning behind the override
ZSH_CUSTOM=$HOME/.zsh_custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rbenv kubectl kops helm history-substring-search zsh-syntax-highlighting zsh-autosuggestions terraform)

source $ZSH/oh-my-zsh.sh

# load every file in ~/.zsh.d formatted as "SXX_some_task", XX being a number for script ordering              
for zshrc_snipplet in ~/.zsh.d/S[0-9][0-9]*[^~] ; do           
        source $zshrc_snipplet         
done

if [[ -z $TMUX ]]; then
        #Added by Heroku Toolbelt
        export PATH="/usr/local/heroku/bin:~/bin:$PATH"
fi

export VISUAL="nvim"
export EDITOR="nvim"

# for kops wrapper
export KOPS_MFA_ARN="arn:aws:iam::459931222334:mfa/dpetersen"

# Vi mode
bindkey -v
# Enable Ctrl-v v to edit current command in vim mode
bindkey -M vicmd "^V" edit-command-line
# Don't wait half a second to get out of insert mode
export KEYTIMEOUT=1

# Disable shared history, the bane of my existence in tmux windows. Ratio of
# accidental vs. intended commands run: 50-1.
setopt no_share_history

# Something to do with getting C-s mappable in Vim, and maybe stopping it from
# halting things altogether like this is the 1970s.
# source: http://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
stty -ixon

eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
