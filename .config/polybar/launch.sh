#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

echo "---" > /tmp/polybar.log
polybar example 2>&1 | tee -a /tmp/polybar.log & disown
