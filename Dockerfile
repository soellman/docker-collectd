#FROM alpine:3.2
FROM debian:wheezy
MAINTAINER Oliver Soell <oliver@soell.net>

#RUN apk add -U collectd collectd-curl collectd-rrdtool collectd-write_http py-jinja2 btrfs-progs && rm -rf /var/cache/apk/*

ENV COLLECTD_VERSION 5.4.2

RUN apt-get update -y
RUN apt-get install -y build-essential python-pip libcurl4-openssl-dev libyajl-dev btrfs-tools curl python-jinja2
RUN cd /opt && \
  curl -sL http://collectd.org/files/collectd-${COLLECTD_VERSION}.tar.gz | tar zx && \
  cd collectd-${COLLECTD_VERSION} && \
  find . -name \*.c | while read file ; do sed -i 's|/proc/|/host/proc/|g' $file ; done && \
  ./configure && \
  make && \
  make install


# Override required!
ENV HOSTNAME default

# Env vars which represent multiple items are comma-separated
# Builtins:
# ENV DF_MOUNTS      # e.g. /, /data
# ENV DISK_DISKS     # e.g. xvda, xvdb

# Additions:
# ENV BTRFS_MOUNTS   # e.g. /var/lib/docker/btrfs, /data
# ENV RIAK_STATS_URL # e.g. http://localhost:8098/stats

# -> Librato
# ENV LIBRATO_EMAIL
# ENV LIBRATO_TOKEN

ENV CONFDIR /opt/collectd/etc

ADD . ${CONFDIR}

ENTRYPOINT ["/opt/collectd/etc/docker-start.sh"]
#CMD ["/usr/sbin/collectd", "-f"]
CMD ["/opt/collectd/sbin/collectd", "-f"]
