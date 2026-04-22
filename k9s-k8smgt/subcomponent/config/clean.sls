# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

include:
  - {{ sls_service_clean }}

k9s-k8smgt-subcomponent-config-clean-file-absent:
  file.absent:
    - name: {{ k9s_k8smgt.subcomponent.config }}
    - watch_in:
        - sls: {{ sls_service_clean }}
