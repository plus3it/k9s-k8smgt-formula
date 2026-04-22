# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{%- set skel_dir = '/etc/skel/.config/k9s' %}

Ensure K9S skeleton directory has been removed:
  file.absent:
    - name: '{{ skel_dir }}'
