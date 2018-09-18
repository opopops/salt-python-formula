{%- from "python/map.jinja" import python with context %}

include:
  - python.pip.install

{%- if python.get('virtualenv', False) %}
python_virtualenv_package:
  pip.installed:
    {%- if python.get('major_version', False) > 2 %}
    - bin_env: {{python.pip3_bin}}
    {%- endif %}
    {%- if python.virtualenv.get('version', False) %}
    - name: virtualenv == {{python.virtualenv.version}}
    {%- else %}
    - name: virtualenv
    {%- endif %}
    - reload_modules: True
    - require:
      - sls: python.pip.install
{%- endif %}
