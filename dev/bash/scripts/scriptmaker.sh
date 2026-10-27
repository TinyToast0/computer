#!/usr/bin/env bash

TYPE=$1
NAME=$2

case $TYPE in
bash)
  touch $NAME
  chmod +x ./$NAME
  echo "#!/usr/bin/env bash" >>$NAME
  ;;
odin)
  touch $NAME
  echo "package main" >>$NAME
  ;;
py | python)
  touch $NAME
  echo "#!/usr/bin/env/ python3

print('Hello World')" >>$NAME
  ;;
*)
  echo "Invalid bitch"
  exit 1
  ;;
esac
