#! /bin/zsh

# load every file in ~/.zsh.d formatted as "SXX_some_task", XX being a number for script ordering
for zshrc_snipplet in ~/.zsh.d/S[0-9][0-9]*[^~] ; do
        source $zshrc_snipplet
done

# rvm installer added line:
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi
