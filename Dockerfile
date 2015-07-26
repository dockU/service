FROM dock0/service
MAINTAINER Jon Chen <bsd@voltaire.sh>

VOLUME ["/opt/service/"]

ENV ETCD_NODE etcd-master.a.serv.pw
ENV ETCD_CA_KEY /opt/service/ssl/certs/etcd-ca.a.serv.pw.ca
ENV ETCD_CERT /opt/service/ssl/certs/etcd-localhost.crt
ENV ETCD_KEY /opt/service/ssl/private/etcd-localhost.key

RUN mkdir -p /etc/confd/{conf.d,templates}
ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/bin/confd
RUN chmod +x /usr/bin/confd

ONBUILD RUN /usr/bin/confd -onetime -backend etcd -node $ETCD_NODE -client-ca-keys $ETCD_CA_KEY -client-cert $ETCD_CERT -client-key $ETCD_KEY
