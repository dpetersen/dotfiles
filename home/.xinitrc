# This swaps alt and super. You should be able to do this with Xmodmap, and I
# used to. But for some reason now it's failing, and this works, and I'm sick
# of fiddling with it.
#
# This is commented out for now on my work desktop because I don't need these swapped on my current keyboard.
# 
# setxkbmap -option altwin:swap_alt_win

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Old stuff I ran previously
# blueman-applet &
#dropbox &

# Stuff I think I can run in any Window Manager
xbindkeys
redshift &
copyq &

# Stuff that I think only applies to bspwm
~/.config/polybar/launch.sh &
picom --config $HOME/.config/picom.confg &
mkdir -p .logs
exec bspwm

# exec twm
# exec startxfce4
