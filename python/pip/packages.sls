{%- from "python/map.jinja" import python with context %}

include:
  - python.pip.install

{%- if 'pip' in python %}
  {%- for package, params in python.pip.get('packages', {}).items() %}
    {%- set package_name = params.name|default(package) %}
    {%- set config       = python.pip.get('config', {}) %}
    {%- do config.update(params.get('config', {})) %}
python_pip_{{package}}_package:
  pip.installed:
    - name: {{ package_name }}
    {%- for k, v in config.items() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - require:
      - sls: python.pip.install
  {%- endfor %}
{%- endif %}
