#!/usr/bin/env bash

MP4_PATH="$1"
OUT_PATH="$HOME/.cache/ffmp4"
[[ -z "$MP4_PATH" ]] && echo "[ERROR] Expected a path, got empty." >&2 && exit 1
[[ ! -f "$MP4_PATH" ]] && echo "[ERROR] File given is not valid: MP4_PATH" >&2 && exit 1
FILENAME="$(basename "$MP4_PATH")"
FILENAME="${FILENAME%.mp4}.png"

mkdir -p "$OUT_PATH"

ffmpeg -i "$MP4_PATH" -frames:v 1 "$OUT_PATH/$FILENAME" || {
  echo "[ERROR] ffmpeg failed. git gud" && exit 1
}

echo "[SUCCESS] Create $FILENAME at $OUT_PATH" && exit 0
