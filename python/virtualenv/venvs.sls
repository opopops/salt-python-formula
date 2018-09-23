{%- from "python/map.jinja" import python with context %}

include:
  - python.virtualenv.install

{%- if 'virtualenv' in python %}
  {%- for venv, params in python.virtualenv.get('venvs', {}).items() %}
    {%- set venv_path = params.path|default(venv) %}
    {%- set options   = params.get('options', {}) %}
python_virtualenv_{{venv}}_directory:
  file.directory:
    - name: {{venv_path}}
    {%- if params.get('user', False) %}
    - user: {{params.user}}
    {%- endif %}
    {%- if params.get('group', False) %}
    - group: {{params.group}}
    {%- endif %}
    {%- if params.get('mode', False) %}
    - mode: {{params.mode}}
    {%- endif %}

    {%- if 'config' in params %}
python_virtualenv_{{venv}}_pip_config:
  file.managed:
    {%- if params.get('user', False) %}
    - user: {{params.user}}
    {%- endif %}
    {%- if params.get('group', False) %}
    - group: {{params.group}}
    {%- endif %}
    - mode: 644
    - makedirs: True
  ini.options_present:
    - separator: ' = '
    - strict: True
    - sections: {{params.config}}
    - require_in:
      - virtualenv: python_virtualenv_{{venv}}
    {%- endif %}

python_virtualenv_{{venv}}:
  virtualenv.managed:
    - name: {{venv_path}}
    {%- for k, v in options.items() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - require:
      - sls: python.virtualenv.install
      - file: python_virtualenv_{{venv}}_directory
  {%- endfor %}
{%- endif %}
