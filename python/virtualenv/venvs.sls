{%- from "python/map.jinja" import python with context %}

include:
  - python.virtualenv.install

{%- if 'virtualenv' in python %}
  {%- for venv, params in python.virtualenv.get('venvs', {}).items() %}
    {%- set venv_path = params.path|default(venv) %}
    {%- set config    = python.virtualenv.get('config', {}) %}
    {%- do config.update(params.get('config', {})) %}
python_virtualenv_{{venv}}:
  file.directory:
    - name: {{venv_path}}
    {%- if config.get('user', False) %}
    - user: {{config.user}}
    {%- endif %}
    {%- if config.get('group', False) %}
    - group: {{config.group}}
    {%- endif %}
    {%- if config.get('mode', False) %}
    - mode: {{config.mode}}
    {%- endif %}
  virtualenv.managed:
    - name: {{venv_path}}
    {%- for k, v in config.items() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - require:
      - sls: python.virtualenv.install
  {%- endfor %}
{%- endif %}
