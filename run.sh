#!/bin/sh
set -e
main(){
  IMG=the-language-builder
  HOUSE="$(pwd)/home"
  docker build -t "$IMG" \
    --build-arg UNAME="$(id -nu)" --build-arg GNAME="$(id -ng)" \
    --build-arg UID="$(id -u)" --build-arg GID="$(id -g)" \
    --build-arg HOME="$HOUSE" --build-arg WORKDIR="$HOUSE" \
    .
  hidden_v=""
  hidden_tmp="$(pwd)/.tmp$RANDOM$RANDOM"
  mkdir "$hidden_tmp"
  for hidden in "$HOUSE"/src/*/.git; do
    [ -e "$hidden" ] && hidden_v="$hidden_v -v $hidden_tmp:$hidden:ro"
  done
  docker run -it --rm -v "$HOUSE":"$HOUSE" $hidden_v "$IMG"
  rmdir "$hidden_tmp"
  exit
}
main
