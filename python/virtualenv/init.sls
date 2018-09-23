{%- from "python/map.jinja" import python with context %}

include:
  - python.pip.install
  - python.pip.config
  - python.virtualenv.install
  - python.virtualenv.venvs
