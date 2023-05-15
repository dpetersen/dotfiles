#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

m=DP-0
# I'm not sure why this stopped working after I got a new video card. The
# output of this command when I run it is correct. Shrug. I'll deal with it
# when I have to make this config work on multiple machines...
#m=$(xrandr --query | grep " connected" | grep primary | cut -d" " -f1)
cmd=(env "MONITOR=$m" polybar --reload main)

if [[ $# -gt 0 ]] && [[ $1 = "block" ]]; then
	exec "${cmd[@]}"
else
	"${cmd[@]}" &
fi
