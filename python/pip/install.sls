{%- from "python/map.jinja" import python with context %}

include:
  - python.install

python_pip_packages:
  pkg.installed:
    - pkgs: {{python.pip_pkgs}}
    - reload_modules: True
    - require:
      - pkg: python_packages

{%- if 'pip' in python %}
  {%- if python.pip.get('upgrade', False) %}
python_pip_upgrade:
  pip.installed:
    {%- if python.get('major_version', False) > 2 %}
    - bin_env: {{python.python3_bin}}
    {%- endif %}
    {%- if python.pip.get('version', False) %}
    - name: pip == {{python.pip.version}}
    {%- else %}
    - name: pip
    {%- endif %}
    - upgrade: True
    - reload_modules: True
    - require:
      - pkg: python_pip_packages
  {%- endif %}
{%- endif %}
