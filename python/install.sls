{%- from "python/map.jinja" import python with context %}

python_packages:
  pkg.installed:
    - pkgs: {{python.python_pkgs}}

{%- if python.get('dev', False) %}
python_dev_packages:
  pkg.installed:
    - pkgs: {{python.python_dev_pkgs}}
{%- endif %}
