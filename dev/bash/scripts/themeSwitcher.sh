#!/usr/bin/env bash

THEME="$1"

WAL1="/home/toast/Pictures/GIF/arknights-endfield-sakura-sanctuary-live-wallpaper-wallsflow-com.mp4"
WAL2="/home/toast/Pictures/GIF/aurora-forest-night-live-wallpaper-wallsflow-com.mp4"
WAL3="/home/toast/Pictures/GIF/edge-of-infinity-cosmic-horizon-live-wallpaper-wallsflow-com.mp4"
WAL4="/home/toast/Pictures/GIF/misty-mountains-in-the-rain-live-wallpaper-wallsflow-com.mp4"

PWAL1="/home/toast/Pictures/arknights-endfield-sakura-sanctuary-live-wallpaper-wallsflow-com.png"
PWAL2="/home/toast/Pictures/aurora-forest-night-live-wallpaper-wallsflow-com.png"
PWAL3="/home/toast/Pictures/edge-of-infinity-cosmic-horizon-live-wallpaper-wallsflow-com.png"
PWAL4="/home/toast/Pictures/misty-mountains-in-the-rain-live-wallpaper-wallsflow-com.png"

case "$THEME" in
1)
  wal -i $PWAL1
  waypaper --wallpaper $WAL1
  ;;
2)
  wal -i $PWAL2
  waypaper --wallpaper $WAL2
  ;;
3)
  wal -i $PWAL3
  waypaper --wallpaper $WAL3
  ;;
4)
  wal -i $PWAL4
  waypaper --wallpaper $WAL4
  ;;
*)
  ;;
esac

cp /home/toast/.cache/wal/discord-colors.css /home/toast/.config/Vencord/themes/discord-colors.css
cp /home/toast/.cache/wal/colors-mako /home/toast/.config/mako/config1.base
cp /home/toast/.cache/wal/hyprColors.lua /home/toast/.config/hypr/config/
cp /home/toast/.cache/wal/noctalia.json /home/toast/.config/noctalia/colors.json
makoctl reload
pywalfox update
