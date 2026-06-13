#!/bin/bash

current=$(pactl get-default-sink)

sink1="alsa_output.pci-0000_30_00.6.analog-stereo"   # Speakers
sink2="alsa_output.pci-0000_10_00.1.hdmi-stereo"     # Headset

if [ "$current" = "$sink1" ]; then
    new_sink="$sink2"
    label="🎧 Headset (HDMI)"
else
    new_sink="$sink1"
    label="🔊 Speakers"
fi

# set default sink
pactl set-default-sink "$new_sink"

# move all running streams to new sink
pactl list short sink-inputs | while read stream; do
    pactl move-sink-input $(echo $stream | cut -f1) "$new_sink" 2>/dev/null
done

# desktop notification
notify-send "🔀 Audio Output Switched" "Now using: $label"

