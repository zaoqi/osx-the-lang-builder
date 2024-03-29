#!/bin/sh
set -e
main(){
  IMG=local_host/builder-home
  HOUSE="$(pwd)/home"
  docker build -t "$IMG" \
    --build-arg USER="$(id -un)" --build-arg GROUP="$(id -gn)" \
    --build-arg UID="$(id -u)" --build-arg GID="$(id -g)" \
    --build-arg WORKDIR="$HOUSE" --build-arg HOME="$HOUSE" \
    .
  hidden_v=""
  hidden_tmp="$(pwd)/.teMpFoRHiDeDoTgIt"
  rm -fr "$hidden_tmp"
  mkdir "$hidden_tmp"
  for hidden in "$HOUSE"/src/*/.git; do
    [ -e "$hidden" ] && hidden_v="$hidden_v -v $hidden_tmp:$hidden:ro"
  done
  docker run -it --rm -v "$HOUSE":"$HOUSE" --env PS1="[\h:\W]\$ " $hidden_v "$IMG" /bin/bash
  rmdir "$hidden_tmp"
  exit
}
main
