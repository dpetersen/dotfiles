# This swaps alt and super. You should be able to do this with Xmodmap, and I
# used to. But for some reason now it's failing, and this works, and I'm sick
# of fiddling with it.
setxkbmap -option altwin:swap_alt_win

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xbindkeys
redshift &
#blueman-applet &
#dropbox &
copyq &
~/.config/polybar/launch.sh &
mkdir -p .logs

exec bspwm
#exec twm
