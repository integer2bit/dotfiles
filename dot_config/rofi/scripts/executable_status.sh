#!/usr/bin/env bash

[ "$ROFI_RETV" = "1" ] && exit 0

date_str=$(date '+%Y-%m-%d %H:%M  %A')
battery_cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "?")
battery_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "")

if [ "$battery_status" = "Charging" ]; then
    battery_icon="\uf1e6"
elif [ "$battery_cap" -le 10 ] 2>/dev/null; then
    battery_icon="\uf244"
elif [ "$battery_cap" -le 30 ] 2>/dev/null; then
    battery_icon="\uf243"
elif [ "$battery_cap" -le 60 ] 2>/dev/null; then
    battery_icon="\uf242"
elif [ "$battery_cap" -le 85 ] 2>/dev/null; then
    battery_icon="\uf241"
else
    battery_icon="\uf240"
fi

battery_display="  Battery: ${battery_cap}%"
[ -n "$battery_status" ] && battery_display="$battery_display ($battery_status)"

wifi_ssid=$(nmcli -t -f NAME con show --active 2>/dev/null | head -1)
wifi_ip=$(nmcli -t -f IP4.ADDRESS dev show wlan0 2>/dev/null | sed 's/^IP4.ADDRESS\[[0-9]*\]://' | cut -d/ -f1)
if [ -n "$wifi_ssid" ]; then
    wifi_display="\uf1eb  $wifi_ssid  $wifi_ip"
else
    wifi_display="\uf1eb  Disconnected"
fi

bt_powered=$(bluetoothctl show 2>/dev/null | grep -c "Powered: yes")
if [ "$bt_powered" -gt 0 ]; then
    bt_devices=$(bluetoothctl devices Connected 2>/dev/null | wc -l)
    bt_display="\uf293  On"
    [ "$bt_devices" -gt 0 ] && bt_display="$bt_display ($bt_devices connected)"
else
    bt_display="\uf293  Off"
fi

vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
vol_val=$(echo "$vol_raw" | awk '{print $2}')
vol_pct=$(awk "BEGIN {printf \"%.0f\", $vol_val * 100}")
if echo "$vol_raw" | grep -q "MUTED"; then
    vol_icon="\uf026"
else
    if [ "$vol_pct" -eq 0 ]; then
        vol_icon="\uf026"
    elif [ "$vol_pct" -le 40 ]; then
        vol_icon="\uf027"
    else
        vol_icon="\uf028"
    fi
fi
muted_suffix=""
echo "$vol_raw" | grep -q "MUTED" && muted_suffix=" (Muted)"
vol_display="$vol_icon  Volume: ${vol_pct}%$muted_suffix"

bri_val=$(brightnessctl info 2>/dev/null | grep -oP '\(\K[0-9]+(?=%)')
if [ -n "$bri_val" ]; then
    bri_display="\uf185  Brightness: ${bri_val}%"
else
    bri_display=""
fi

ws_output=$(niri msg workspaces 2>/dev/null)
current_ws=$(echo "$ws_output" | grep '^\s*\*' | sed 's/^\s*\*\s*//')
ws_display="\uf108  Workspace $current_ws"

window_title=$(niri msg focused-window 2>/dev/null | grep '^  Title:' | sed 's/^  Title: "\(.*\)"$/\1/' | head -c 80)
if [ -n "$window_title" ]; then
    ws_display="$ws_display  $window_title"
fi

echo -e "\uf073  \uf017  $date_str"
echo -e "$battery_icon$battery_display"
echo -e "$wifi_display"
echo -e "$bt_display"
echo -e "$vol_display"
[ -n "$bri_display" ] && echo -e "$bri_display"
echo -e "$ws_display"
