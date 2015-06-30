LoadPlugin tcpconns

<Plugin "tcpconns">
{% for port in TCPCONNS_LOCALPORTS %}
  LocalPort {{ port }}
{% endfor %}
  AllPortsSummary "true"
</Plugin>
