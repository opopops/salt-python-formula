{%- from "python/map.jinja" import python with context %}

include:
  - python.pip.install

{%- if 'pip' in python %}
  {%- for requirements, params in python.pip.get('requirements', {}).items() %}
    {%- set requirements_source = params.source|default(requirements) %}
python_pip_{{requirements}}_requirements:
  pip.installed:
    - requirements: {{ requirements_source }}
    {%- for k, v in params.get('options', {}).items() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - require:
      - sls: python.pip.install
  {%- endfor %}
{%- endif %}
