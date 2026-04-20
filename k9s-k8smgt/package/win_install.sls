# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{%- set temp_dir = salt['environ.get']('TEMP', 'C:\\temp') %}
{%- set stage_file = temp_dir ~ '\\k9s_windows_amd64.zip' %}

Add K9s to System PATH:
  win_path.exists:
    - name: 'C:\Program Files\K9S'
    - require:
      - archive: Extract K9s Bundle

Delete Staged K9s Archive:
  file.absent:
    - name: '{{ stage_file }}'
    - require:
      - archive: Extract K9s Bundle

Extract K9s Bundle:
  archive.extracted:
    - enforce_toplevel: False
    - name: 'C:\\Program Files\\K9S'
    - overwrite: True
    - require:
      - file: 'Stage K9s Windows Archive'
    - skip_verify: True
    - source: '{{ stage_file }}'

Refresh Environment:
  cmd.run:
    - name: |
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVaria
ble("Path","User")
    - onchanges:
      - win_path: Add K9s to System PATH
    - shell: powershell

Stage K9s Windows Archive:
  file.managed:
    - name: '{{ stage_file }}'
    - source: '{{ k9s_k8smgt.pkg.name }}'
    - skip_verify: True
