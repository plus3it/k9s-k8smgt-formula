# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

# This kills the binaries (etc.) that came from directly "unrolling" the
# initially-downloade archive-file
Remove K9s Installation Directory:
  file.absent:
    - name: 'C:\\Program Files\\K9S'
