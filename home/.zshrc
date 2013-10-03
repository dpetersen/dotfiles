#! /bin/zsh

# load every file in ~/.zsh.d formatted as "SXX_some_task", XX being a number for script ordering
for zshrc_snipplet in ~/.zsh.d/S[0-9][0-9]*[^~] ; do
        source $zshrc_snipplet
done

export RBENV_ROOT="/opt/rbenv"
export PATH=$RBENV_ROOT/bin:$PATH
source $RBENV_ROOT/completions/rbenv.zsh
eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
