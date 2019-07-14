{%- from "python/map.jinja" import python with context %}

include:
  - python.pip

{%- if python.get('virtualenv', False) %}
python_virtualenv_package:
  pip.installed:
    - bin_env: {{python.python_bin}}
    {%- if python.virtualenv.get('version', False) %}
    - name: virtualenv == {{python.virtualenv.version}}
    {%- else %}
    - name: virtualenv
    {%- endif %}
    - reload_modules: True
    - require:
      - sls: python.pip.install
      {%- if 'config' in python.pip %}
      - sls: python.pip.config
      {%- endif %}
  {%- if 'python3_bin' in python.keys() %}
python3_virtualenv_package:
  pip.installed:
    - bin_env: {{python.python3_bin}}
    {%- if python.virtualenv.get('version', False) %}
    - name: virtualenv == {{python.virtualenv.version}}
    {%- else %}
    - name: virtualenv
    {%- endif %}
    - reload_modules: True
    - require:
      - sls: python.pip.install
      {%- if 'config' in python.pip %}
      - sls: python.pip.config
      {%- endif %}
  {%- endif %}
{%- endif %}
