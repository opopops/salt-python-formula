{%- from "python/map.jinja" import python with context %}

include:
  - python.pip.install

{%- if 'pip' in python %}
  {%- for package in python.pip.get('packages', []) %}
    {%- if package is mapping %}
      {%- set package_name = package.keys()[0] %}
      {%- set params       = package.get(package.keys()[0])|default({}) %}
    {%- else %}
      {%- set package_name = package %}
    {%- endif %}
python_pip_{{package_name}}_install:
  pip.installed:
    {%- if package is mapping %}
      {%- if not package.get('requirements', False) %}
    - name: {{ package_name }}
      {%- endif %}
    {%- else %}
    - name: {{ package_name }}
    {%- endif %}
    {%- if package is mapping %}
      {%- for k, v in package.get(package_name).items() %}
    - {{k}}: {{v}}
      {%- endfor %}
    {%- endif %}
    - require:
      - sls: python.pip.install
  {%- endfor %}
{%- endif %}
