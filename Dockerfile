FROM dock0/service
MAINTAINER Jon Chen <bsd@voltaire.sh>

VOLUME ["/opt/secrets/"]

ENV ETCD_NODE coreos.aws.nerdrage.biz
ENV ETCD_CA_KEY /opt/secrets/tls/nerdrage.crt
ENV ETCD_CERT /opt/secrets/tls/coreos.aws.nerdrage.biz
ENV ETCD_KEY /opt/secrets/tls/coreos.aws.nerdrage.biz

RUN mkdir -p /etc/confd/{conf.d,templates}
RUN mkdir -p /opt/secrets/tls

# install confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/bin/confd
RUN chmod +x /usr/bin/confd

ONBUILD RUN /usr/bin/confd -onetime -backend etcd -node $ETCD_NODE -client-ca-keys $ETCD_CA_KEY -client-cert $ETCD_CERT -client-key $ETCD_KEY
