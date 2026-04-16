# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

include:
  - {{ sls_config_file }}

k9s-k8smgt-service-running-service-running:
  service.running:
    - name: {{ k9s_k8smgt.service.name }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
