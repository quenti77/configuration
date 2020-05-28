#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
MONITORS=$(xrandr -q | grep " connected" | cut -d ' ' -f1)
for mon in $MONITORS; do
    echo "Bars on ${mon}"
    MONITOR=$mon polybar -c ~/.config/polybar/config.ini top &
    MONITOR=$mon polybar -c ~/.config/polybar/config.ini bottom &
done
