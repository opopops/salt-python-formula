{%- from "python/map.jinja" import python with context %}

include:
  - python.pip.install

{%- if 'pip' in python %}
  {%- for package, params in python.pip.get('packages', {}).items() %}
    {%- set package_name = params.name|default(package) %}
python_pip_{{package}}_package:
  pip.installed:
    - name: {{ package_name }}
    {%- for k, v in params.get('options', {}).items() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - require:
      - sls: python.pip.install
  {%- endfor %}
{%- endif %}
