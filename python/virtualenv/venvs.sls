{%- from "python/map.jinja" import python with context %}

include:
  - python.virtualenv.install

{%- if 'virtualenv' in python %}
  {%- for venv, params in python.virtualenv.get('venvs', {}).items() %}
python_virtualenv_{{venv}}_directory:
  file.directory:
    - name: {{venv}}
    {%- if params.get('user', False) %}
    - user: {{params.user}}
    {%- endif %}
    {%- if params.get('group', False) %}
    - group: {{params.group}}
    {%- endif %}
    {%- if params.get('mode', False) %}
    - mode: {{params.mode}}
    - makedirs: True
    {%- endif %}

    {%- if 'pip_config' in params %}
python_virtualenv_{{venv}}_pip_config:
  file.managed:
    - name: {{venv | path_join('pip.conf')}}
    {%- if params.get('user', False) %}
    - user: {{params.user}}
    {%- endif %}
    {%- if params.get('group', False) %}
    - group: {{params.group}}
    {%- endif %}
    - mode: 644
    - makedirs: True
  ini.options_present:
    - name: {{venv | path_join('pip.conf')}}
    - separator: '='
    - strict: True
    - sections: {{params.pip_config}}
    - require_in:
      - virtualenv: python_virtualenv_{{venv}}
    {%- endif %}

python_virtualenv_{{venv}}:
  virtualenv.managed:
    - name: {{venv}}
    {%- for k, v in params.items() %}
      {%- if k not in ['name', 'group', 'mode', 'pip_config'] %}
    - {{k}}: {{v}}
      {%- endif %}
    {%- endfor %}
    - require:
      - sls: python.virtualenv.install
      - file: python_virtualenv_{{venv}}_directory
  {%- endfor %}
{%- endif %}
