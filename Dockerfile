FROM dock0/service
MAINTAINER Jon Chen <bsd@voltaire.sh>

RUN pacman -Syyu --needed --noconfirm
ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/bin/confd
