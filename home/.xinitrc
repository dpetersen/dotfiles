[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# xbindkeys
# redshift &
# blueman-applet &
# mkdir -p .logs
# xmonad 2> .logs/xmonad.err > .logs/xmonad.log


xbindkeys
redshift &
blueman-applet &
dropbox &
copyq &
~/.config/polybar/launch.sh &
mkdir -p .logs

exec bspwm
