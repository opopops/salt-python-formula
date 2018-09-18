{%- from "python/map.jinja" import python with context %}

include:
  - python.pip.install
  - python.virtualenv.install
  - python.virtualenv.venvs
