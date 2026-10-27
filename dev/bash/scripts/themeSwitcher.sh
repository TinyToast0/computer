#!/usr/bin/env bash

THEME="$1"

WAL1="~/Wallpapers/Videos/blackHole1.mp4"
WAL2="~/Wallpapers/Videos/blackHole2.mp4"
WAL3="~/Wallpapers/Videos/galaxy.mp4"
WAL4="~/Wallpapers/Videos/nebula.mp4"
WAL5="~/Wallpapers/Videos/forest.mp4"

PWAL1="/home/toast/Wallpapers/blackHole1.png"
PWAL2="/home/toast/Wallpapers/blackHole2.png"
PWAL3="/home/toast/Wallpapers/galaxy.png"
PWAL4="/home/toast/Wallpapers/nebula.png"
PWAL5="/home/toast/Wallpapers/forest.png"

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
5)
  wal -i $PWAL5
  waypaper --wallpaper $WAL5
  ;;
6)
  wal -i $PWAL6
  waypaper --wallpaper $WAL6
  ;;
7)
  wal -i $PWAL7
  waypaper --wallpaper $WAL7
  ;;
8)
  wal -i $PWAL8
  waypaper --wallpaper $WAL8
  ;;
*)
  ;;
esac

cp /home/toast/.cache/wal/discord-colors.css /home/toast/.config/Vencord/themes/discord-colors.css
cp /home/toast/.cache/wal/colors-mako /home/toast/.config/mako/config1.base
cp /home/toast/.cache/wal/hyprColors.lua /home/toast/.config/hypr/config/
makoctl reload
pywalfox update
