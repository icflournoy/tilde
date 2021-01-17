{% for package in pillar['base']['packages'] %}
{{ package }}:
  pkg.installed: []
{% endfor %}