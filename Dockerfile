FROM soellman/debian
MAINTAINER Oliver Soell <oliver@soell.net>

RUN apt-get install -y build-essential python-pip libcurl4-openssl-dev libyajl-dev btrfs-tools
RUN cd /opt && \
  curl http://collectd.org/files/collectd-5.4.1.tar.gz | tar zx && \
  cd collectd-5.4.1 && \
  ./configure --prefix=/usr/local && \
  make && \
  make install

RUN pip install envtpl
ADD collectd.conf.tpl /usr/local/etc/collectd.conf.tpl
ADD collectd.d /usr/local/etc/collectd.d
CMD for template in /usr/local/etc/collectd.conf.tpl /usr/local/etc/collectd.d/*.tpl ; do envtpl $template ; done && exec collectd -f
