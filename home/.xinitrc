[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xbindkeys
redshift &
mkdir -p .logs
xmonad 2> .logs/xmonad.err > .logs/xmonad.log
