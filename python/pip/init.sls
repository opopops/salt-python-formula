{%- from "python/map.jinja" import python with context %}

include:
  - python.install
  {%- if python.pip.get('config', False) %}
  - python.pip.config
  {%- endif %}
  - python.pip.install
  {%- if python.pip.get('packages', False) %}
  - python.pip.packages
  {%- endif %}
