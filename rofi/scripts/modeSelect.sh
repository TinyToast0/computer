#!/usr/bin/env bash

CHOICE=$(printf "Colemak\nQwerty" | rofi -dmenu -theme powermenu -p "Choose Mode")

case $CHOICE in
Colemak)
  cp ~/.config/hypr/config/templates/colemakConfig/input.lua ~/.config/hypr/config/input.lua
  hyprctl dispatch 'hl.dsp.submap("colemak")'
  ;;
Qwerty)
  cp ~/.config/hypr/config/templates/qwertyConfig/input.lua ~/.config/hypr/config/input.lua
  hyprctl dispatch 'hl.dsp.submap("regular")'
  ;;
esac
