# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{% set k9s_rel_path = 'AppData\\Local\\k9s' %}

Seed K9s Config for Future Users:
  file.managed:
    - name: 'C:\\Users\\Default\\{{ k9s_rel_path }}\\config.yaml'
    - source: salt://{{ tplroot }}/files/k9s_config.yaml
    - makedirs: True
    - user: System
    - group: Administrators

Seed K9s Skins for Future Users:
  file.recurse:
    - name: 'C:\\Users\\Default\\{{ k9s_rel_path }}\\skins'
    - source: salt://{{ tplroot }}/files/skins
    - makedirs: True
