LoadPlugin df

<Plugin "df">
{% for mount in DF_MOUNTS %}
  MountPoint "{{ mount }}"
{% endfor %}
</Plugin>

