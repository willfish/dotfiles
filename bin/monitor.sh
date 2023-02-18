#! /usr/bin/env bash

set -e # Exit on error
set -u # Exit on undefined variable

# This script is used to configure the xrandr settings for my laptop and desktop monitor
# It is called by the i3 config file
#
# The script is called with the following arguments:
# $1: The variant of the monitor configuration to use
#     1: Laptop only
#     2: Laptop + external monitor
#     3: External monitor only


# Laptop only
if [ "$1" = "laptop" ]; then
    xrandr --output eDP1 --auto --output DP1 --off
fi

# Laptop + external monitor
if [ "$1" = "laptop-external" ]; then
    xrandr --output eDP-1 --auto --primary --rotate normal --output eDP-1 --preferred --rotate normal --below DP-2
fi

# External monitor only
if [ "$1" = "external" ]; then
    xrandr --output eDP1 --off --output DP1 --auto --primary --rotate normal
fi
