FROM zaoqi/the-language-builder
ARG UID=0
ARG GID=0
ARG USER=root
ENV USER="$USER"
ARG GROUP=root
ARG WORKDIR=/
ARG HOME=/
ARG SHELL=/bin/bash
ENV HOME="$HOME"
RUN echo "$GROUP:x:$GID:" > /etc/group && \
  echo "$USER:x:$UID:$GID:Linux User,,,:$HOME:/bin/bash" > /etc/passwd && \
  echo "$USER:!::0:::::" > /etc/shadow
USER "$UID:$GID"
WORKDIR "$WORKDIR"
