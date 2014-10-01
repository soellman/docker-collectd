Hostname "{{ HOSTNAME }}"

FQDNLookup false
Interval 10
Timeout 2
ReadThreads 5
WriteThreads 5

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

Include "/usr/local/etc/collectd.d/*.conf"
