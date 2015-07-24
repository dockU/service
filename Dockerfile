FROM dock0/service
MAINTAINER Jon Chen <bsd@voltaire.sh>

ENV ETCD_NODE etcd-master.a.serv.pw
ENV ETCD_CA_KEY /etc/ssl/certs/etcd-ca.a.serv.pw.ca
ENV ETCD_CERT /etc/ssl/certs/etcd-localhost.crt
ENV ETCD_KEY /etc/ssl/private/etcd-localhost.key

RUN pacman -Syyu --needed --noconfirm

RUN mkdir -p /etc/confd/{conf.d,templates}
ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/bin/confd

ONBUILD RUN /usr/bin/confd -onetime -backend etcd -node $ETCD_NODE -client-ca-keys $ETCD_CA_KEY -client-cert $ETCD_CERT -client-key $ETCD_KEY
