FROM alpine:3.2
MAINTAINER Oliver Soell <oliver@soell.net>

RUN apk add -U collectd collectd-curl collectd-rrdtool collectd-write_http py-jinja2 btrfs-progs && rm -rf /var/cache/apk/*

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

ENV CONFDIR /etc/collectd

ADD . ${CONFDIR}

WORKDIR ${CONFDIR}
ENTRYPOINT ["./docker-start.sh"]
CMD ["/usr/sbin/collectd", "-f"]