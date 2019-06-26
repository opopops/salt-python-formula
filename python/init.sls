{%- from "python/map.jinja" import python with context %}

include:
  - python.install
  - python.ssl
  {%- if python.get('virtualenv', False) %}
  - python.virtualenv
  {%- endif %}
  {%- if python.get('pip', False) %}
  - python.pip
  {%- endif %}
