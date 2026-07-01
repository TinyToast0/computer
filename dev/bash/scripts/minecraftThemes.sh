#!/usr/bin/env bash

# Getting the current wallpaper
WALLPAPER=$(grep -oP '(?<=wallpaper = ).*' ~/.config/waypaper/config.ini)

# Wallpaper list

WAL1="~/Pictures/GIF/minecraft-aurora-night-cabin-live-wallpaper-wallsflow-com.mp4"
WAL2="~/Pictures/GIF/minecraft-cherry-blossom-biome_wallsflow-com.mp4"
WAL3="~/Pictures/GIF/Minecraft-Cherry-Blossom-Night.mp4"
WAL4="~/Pictures/GIF/minecraft-enchanted-forest-sun-rays-wallsflow-com.mp4"
WAL5="~/Pictures/GIF/minecraft-tranquil-morning-pond.mp4"
WAL6="~/Pictures/GIF/peaceful-minecraft-forest-path-live-wallpaper-wallsflow-com.mp4"

PWAL1="/home/toast/Pictures/minecraft-aurora-night-cabin-live-wallpaper-wallsflow-com.png"
PWAL2="/home/toast/Pictures/minecraft-cherry-blossom-biome_wallsflow-com.png"
PWAL3="/home/toast/Pictures/Minecraft-Cherry-Blossom-Night.png"
PWAL4="/home/toast/Pictures/minecraft-enchanted-forest-sun-rays-wallsflow-com.png"
PWAL5="/home/toast/Pictures/minecraft-tranquil-morning-pond.png"
PWAL6="/home/toast/Pictures/peaceful-minecraft-forest-path-live-wallpaper-wallsflow-com.png"

case "$WALLPAPER" in
$WAL1)
  waypaper --wallpaper $WAL2
  wal -i $PWAL2
  ;;
$WAL2)
  waypaper --wallpaper $WAL3
  wal -i $PWAL3
  ;;
$WAL3)
  waypaper --wallpaper $WAL4
  wal -i $PWAL4
  ;;
$WAL4)
  waypaper --wallpaper $WAL5
  wal -i $PWAL5
  ;;
$WAL5)
  waypaper --wallpaper $WAL6
  wal -i $PWAL6
  ;;
*)
  waypaper --wallpaper $WAL1
  wal -i $PWAL1
  ;;
esac

cp /home/toast/.cache/wal/discord-colors.css /home/toast/.config/Vencord/themes/discord-colors.css
cp /home/toast/.cache/wal/colors-mako /home/toast/.config/mako/config1.base
cp /home/toast/.cache/wal/hyprColors.lua /home/toast/.config/hypr/config/
cp /home/toast/.cache/wal/noctalia.json /home/toast/.config/noctalia/colors.json
makoctl reload
pywalfox update
