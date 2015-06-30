#!/bin/sh

cd /etc
/usr/local/bin/collectd-render.py && exec "$@"
