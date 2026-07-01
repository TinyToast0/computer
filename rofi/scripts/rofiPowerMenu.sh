#!/usr/bin/env bash

chosen=$(printf "Shutdown\nRestart\nLogout" | rofi -dmenu -theme powermenu -p "Bye Bye!")

case "$chosen" in
Shutdown)
  shutdown now
  ;;
Restart)
  reboot
  ;;
Logout)
  command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'
  ;;
*)
  ;;
esac
