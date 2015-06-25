LoadPlugin disk

<Plugin "disk">
{% for disk in DISK_DISKS %}
  Disk "{{ disk }}"
{% endfor %}
</Plugin>

