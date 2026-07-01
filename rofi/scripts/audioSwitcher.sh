#!/usr/bin/env bash

names="$(pactl -f json list sinks | jq -r '.[] | .name')"
[[ -z "$names" ]] && exit 1
declare -A allowed

allowed["Headphones"]="alsa_output.usb-Astro_Gaming_Astro_A50-00.stereo-chat"
allowed["Speakers"]="alsa_output.pci-0000_00_1f.3.analog-stereo"
selection="$(echo -e "Headphones\nSpeakers" | rofi -dmenu -theme audioSwitcher -p "HMM? MUSIC?")"
[[ -z "$selection" ]] && exit 1
pactl set-default-sink "${allowed["$selection"]}"
