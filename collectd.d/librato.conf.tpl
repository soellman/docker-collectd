LoadPlugin write_http

<Plugin "write_http">
  <URL "https://collectd.librato.com/v1/measurements">
    User "{{ LIBRATO_EMAIL }}"
    Password "{{ LIBRATO_TOKEN }}"
    Format "JSON"
  </URL>
</Plugin>

