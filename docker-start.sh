#!/bin/sh

cd /opt/collectd/etc
./render.py && exec "$@"
