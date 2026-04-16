# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{%- set stage_file = '/tmp/k9s_linux_amd64.rpm' %}

Install K9s RPM:
  pkg.installed:
    - sources:
      - k9s: '{{ stage_file }}'
    - require:
      - file: 'Stage K9s RPM'

Remove staged K9s RPM:
  file.absent:
    - name: '{{ stage_file }}'
    - require:
      - pkg: 'Install K9s RPM'

Stage K9s RPM:
  file.managed:
    - name: '{{ stage_file }}'
    - source: '{{ k9s_k8smgt.pkg.name }}'
    - skip_verify: True
