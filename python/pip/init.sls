{%- from "python/map.jinja" import python with context %}

include:
  - python.install
  - python.pip.install
  {%- if python.pip.get('config', False) %}
  - python.pip.config
  {%- endif %}
  {%- if python.pip.get('packages', False) %}
  - python.pip.packages
  {%- endif %}
  {%- if python.pip.get('requirements', False) %}
  - python.pip.requirements
  {%- endif %}
