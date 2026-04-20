# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{%- set temp_dir = salt['environ.get']('TEMP', 'C:\\temp') %}
{%- set stage_file = temp_dir ~ '\\k9s_windows_amd64.zip' %}

Stage K9s Windows Archive:
  file.managed:
    - name: '{{ stage_file }}'
    - source: '{{ k9s_k8smgt.pkg.name }}'
    - skip_verify: True
