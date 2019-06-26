{%- from "python/map.jinja" import python with context %}

include:
  - python.install

python_ssl_dir:
  file.directory:
    - name: {{ python.ssl_dir }}
    - user: root
    - group: root
    - mode: 755

{%- for certificate, params in python.get('certificates', {}).items() %}
python_pem_{{certificate}}:
  file.managed:
    - name: {{ python.ssl_dir }}/{{certificate}}.pem
    {%- if params.pem.source is defined %}
    - source: {{ params.pem.source }}
      {%- if params.pem.source_hash is defined %}
    - source_hash: {{ params.pem.source_hash }}
      {%- else %}
    - skip_verify: True
      {%- endif %}
    {% else %}
    - contents_pillar: python:certificates:{{certificate}}:pem:contents
    {%- endif %}
    - mode: 600
    - require:
      - file: python_ssl_dir

    {%- if params.get('ca', False) %}
python_ca_{{certificate}}:
  file.managed:
    - name: {{ python.ssl_dir }}/{{certificate}}-ca.crt
    {%- if params.ca.source is defined %}
    - source: {{ params.ca.source }}
      {%- if params.ca.source_hash is defined %}
    - source_hash: {{ params.ca.source_hash }}
      {%- else %}
    - skip_verify: True
      {%- endif %}
    {% else %}
    - contents_pillar: python:certificates:{{certificate}}:ca:contents
    {%- endif %}
    - mode: 644
    - require:
      - file: python_ssl_dir
    {%- endif %}
{%- endfor %}
