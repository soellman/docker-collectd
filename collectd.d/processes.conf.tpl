LoadPlugin processes

<Plugin "processes">
{% for process in PROCESSES_PROCESSES %}
  Process "{{ process }}"
{% endfor %}
  ProcessMatch "docker" "docker.+bip=.+"
</Plugin>

