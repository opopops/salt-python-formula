{%- from "python/map.jinja" import python with context %}

include:
  - python.pip
  - python.virtualenv.install
  - python.virtualenv.venvs
