[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xbindkeys
redshift &
blueman-applet &
dropbox &
copyq &
~/.config/polybar/launch.sh &
mkdir -p .logs

exec bspwm
