{%- from "python/map.jinja" import python with context %}

include:
  - python.pip.install

{%- if 'pip' in python %}
  {%- if 'config' in python.pip %}
python_pip_conf_file:
  file.managed:
    - name: {{python.pip_conf_file}}
    - mode: 644
    - makedirs: True
  ini.options_present:
    - separator: ' = '
    - strict: True
    - sections: {{python.pip.config}}
  {%- endif %}
{%- endif %}
