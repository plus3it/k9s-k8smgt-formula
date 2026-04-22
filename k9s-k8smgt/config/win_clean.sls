# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

Refresh Environment After Removal:
  cmd.run:
    - name: |
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    - onchanges:
      - win_path: 'Remove K9s from System PATH'
    - shell: powershell

# Using the Jinja loop logic to find and wipe appdata
{%- for user in salt['file.find']('C:\\Users', maxdepth=1, type='d') %}
  {%- set username = user.split('\\')[-1] %}
  {%- if username not in ['Default', 'Public', 'All Users', 'desktop.ini'] %}
Remove K9s Data for user {{ username }}:
  file.absent:
    - name: '{{ user }}\\AppData\\Local\\k9s'
  {%- endif %}
{%- endfor %}

Remove K9s Seeds from Default User:
  file.absent:
    - name: 'C:\\Users\\Default\\AppData\\Local\\k9s'

Remove K9s from System PATH:
  win_path.absent:
    - name: 'C:\\Program Files\\K9S'
