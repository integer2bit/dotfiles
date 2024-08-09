#!/bin/bash
# use `pactl list short sinks` to check your sinks

# Get the current default audio output device
current_sink=$(pactl get-default-sink)

# Define the two audio output devices
sink1="alsa_output.pci-0000_65_00.6.HiFi__Speaker__sink"
# bluetooth headphones
sink2="bluez_output.AC_BF_71_E3_AB_54.1"

# Switching logic
if [ "$current_sink" == "$sink1" ]; then
  pactl set-default-sink $sink2
  echo "Audio output switched to Bluetooth device: $sink2"
elif [ "$current_sink" == "$sink2" ]; then
  pactl set-default-sink $sink1
  echo "Audio output switched to Speaker: $sink1"
else
  echo "The current audio output device is not in the expected list, unable to switch."
fi
