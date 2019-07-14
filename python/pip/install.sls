{%- from "python/map.jinja" import python with context %}

include:
  - python.install
  - python.pip.config

python_pip_packages:
  pkg.installed:
    - pkgs: {{python.pip_pkgs}}
    - reload_modules: True
    - require:
      - pkg: python_packages

{%- if 'pip' in python %}
python_pip_upgrade:
  pip.installed:
    - bin_env: {{python.python_bin}}
    {%- if python.pip.get('version', False) %}
    - name: pip == {{python.pip.version}}
    {%- else %}
    - name: pip
    {%- endif %}
    - upgrade: {{python.pip.get('upgrade', False)}}
    - reload_modules: True
    - require:
      - pkg: python_pip_packages
      {%- if 'config' in python.pip %}
      - file: python_pip_conf_file
      - ini: python_pip_conf_file
      {%- endif %}
  {%- if 'pip3_bin' in python.keys() %}
python3_pip_upgrade:
  pip.installed:
    - bin_env: {{python.python3_bin}}
    {%- if python.pip.get('version', False) %}
    - name: pip == {{python.pip.version}}
    {%- else %}
    - name: pip
    {%- endif %}
    - upgrade: {{python.pip.get('upgrade', False)}}
    - reload_modules: True
    - require:
      - pkg: python_pip_packages
      {%- if 'config' in python.pip %}
      - file: python_pip_conf_file
      - ini: python_pip_conf_file
      {%- endif %}
  {%- endif %}
{%- endif %}
