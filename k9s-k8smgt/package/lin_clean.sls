# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{%- set stage_file = '/tmp/k9s_linux_amd64.rpm' %}

Install K9s RPM:
  pkg.removed:
    - name: 'k9s'
