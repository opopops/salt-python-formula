{%- from "python/map.jinja" import python with context %}

python_packages:
  pkg.installed:
    - pkgs: {{python.python_pkgs}}
