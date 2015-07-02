LoadPlugin tcpconns

<Plugin "tcpconns">
{% for port in TCPCONNS_LOCALPORTS %}
  LocalPort {{ port }}
{% endfor %}
</Plugin>

