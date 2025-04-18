#!/bin/bash

# Get the name of the connected HDMI monitor
# This command queries xrandr, filters lines mentioning " connected",
# then further filters for "HDMI", and finally prints the first word (the monitor name).
HDMI_MONITOR=$(xrandr --query | grep " connected" | grep "HDMI" | awk '{print $1}')

# Check if an HDMI monitor was found
if [ -z "$HDMI_MONITOR" ]; then
  echo "No connected HDMI monitor found."
else
  echo "Found HDMI monitor: $HDMI_MONITOR"
  # Execute the xrandr command to turn off eDP and configure the HDMI monitor
  xrandr --output eDP --off --output "$HDMI_MONITOR" --mode 1920x1080
  echo "Switched display output to $HDMI_MONITOR (1920x1080) and turned off eDP."
fi
