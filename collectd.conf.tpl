Hostname "{{ HOSTNAME }}"

FQDNLookup false
Interval 60
Timeout 2
ReadThreads 6

LoadPlugin cpu
LoadPlugin disk
LoadPlugin interface
LoadPlugin load
LoadPlugin memory

LoadPlugin write_http

<Plugin "write_http">
  <URL "https://collectd.librato.com/v1/measurements">
    User "{{ LIBRATO_EMAIL }}"
    Password "{{ LIBRATO_TOKEN }}"
    Format "JSON"
  </URL>
</Plugin>

Include "/etc/collectd/collect.d/*.conf"
