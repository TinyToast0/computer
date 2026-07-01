#!/usr/bin/env bash

MODE=$(printf "Waybar\nQuickshell\nNoctalia" | rofi -dmenu -theme taskbar -p "Choose Type:")

CHOICE=$(printf "Launch\nKill\nReload" | rofi -dmenu -theme taskbar -p "Choose Command:")

case $MODE in
Waybar)
  case $CHOICE in
  Launch)
    waybar
    ;;
  Kill)
    killall -9 waybar
    ;;
  Reload)
    killall -9 waybar
    wait 1
    waybar
    ;;
  *)
    echo "ERROR: Wrong choice bitch."
    ;;
  esac
  ;;
Quickshell)
  case $CHOICE in
  Launch)
    qs
    ;;
  Kill)
    pkill qs
    ;;
  Reload)
    pkill qs
    wait 1
    qs
    ;;
  *)
    echo "ERROR: Wrong choice bitch."
    ;;
  esac
  ;;
Noctalia)

  case $CHOICE in
  Launch)
    qs -c noctalia-shell
    ;;
  Kill)
    killall -9 qs
    ;;
  Reload)
    killall -9 qs
    wait 1
    qs -c noctalia-shell
    ;;
  *)
    echo "ERROR: Wrong choice bitch."
    ;;
  esac
  ;;
*)
  echo "ERROR: Wrong choice bitch."
  exit 1
  ;;
esac
