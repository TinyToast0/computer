#!/usr/bin/env bash

MAX="$1"

ARTIST=""
TITLE=""
STR=""
SCROLL=""
LEN=0

_updateArtist() {
  artist="$(playerctl metadata artist)"
  [[ -z "$artist" ]] && ARTIST="Unknown Artist" && return 0
  ARTIST="$artist" && return 0
}

_updateTitle() {
  title="$(playerctl metadata title)"
  [[ -z "$title" ]] && TITLE="Unknown Title" && return 0
  TITLE="$title" && return 0
}

_updateStr() {
  _updateArtist
  _updateTitle
  STR="$ARTIST - $TITLE"
  SCROLL="$STR  $STR  "
  LEN=${#STR}
}

while [[ "$LEN" -le "$MAX" ]]; do
  _updateStr
  jq -nc --arg text "$STR" '{text:$text}'
  sleep 0.15
done

for ((pos = 0; ; pos = (pos + 1) % LEN)); do
  _updateStr
  text="${SCROLL:pos:MAX}"
  jq -nc --arg text "$text" '{text:$text}'
  sleep 0.15
done
