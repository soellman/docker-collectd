FROM debian:wheezy
MAINTAINER Oliver Soell <oliver@soell.net>

ENV COLLECTD_VERSION 5.4.1

RUN apt-get update -qq && \
  apt-get install -y build-essential libcurl4-openssl-dev libyajl-dev curl python-pip btrfs-tools && \
  cd /opt && \
  curl http://collectd.org/files/collectd-$COLLECTD_VERSION.tar.gz | tar zx && \
  cd collectd-$COLLECTD_VERSION && \
  ./configure --prefix=/usr/local && \
  make && \
  make install && \
  apt-get autoremove -y build-essential libcurl4-openssl-dev libyajl-dev

RUN pip install envtpl
ADD collectd.conf.tpl /usr/local/etc/collectd.conf.tpl
ADD collectd.d /usr/local/etc/collectd.d
ADD btrfs-data.py /usr/local/bin/btrfs-data.py
CMD for template in /usr/local/etc/collectd.conf.tpl /usr/local/etc/collectd.d/*.tpl ; do envtpl $template ; done && exec collectd -f
