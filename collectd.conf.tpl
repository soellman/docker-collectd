Hostname "{{ HOSTNAME }}"

FQDNLookup false
Interval 10
Timeout 2
ReadThreads 5
WriteThreads 5

LoadModule cpu
LoadModule load
LoadModule memory

Include "/etc/collectd/collectd.d/*.conf"

