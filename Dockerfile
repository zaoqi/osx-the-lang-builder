FROM archlinux/base
ARG MIRROR='https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch'
RUN echo "Server = $MIRROR" > /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm yarn nodejs npm dos2unix racket jdk11-openjdk clang make curl git python2 gawk php base
ARG UNAME
ARG GNAME
ARG UID
ARG GID
ARG HOME
ARG WORKDIR=/
RUN groupadd -g "$GID" "$GNAME" && \
  mkdir -p "$HOME" && \
  chown -R "$UID:$GID" "$HOME" && \
  useradd -MN -d "$HOME" -g "$GID" -u "$UID" "$UNAME"
#RUN echo "$UNAME ALL=(ALL) NOPASSWD: ALL">>/etc/sudoers
USER "$UID:$GID"
WORKDIR "$WORKDIR"
