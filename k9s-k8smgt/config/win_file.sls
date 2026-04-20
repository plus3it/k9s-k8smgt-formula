# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{% set k9s_rel_path = 'AppData\\Local\\k9s' %}

{% for known_local_user in k9s_k8smgt.config.initial_users %}
Configure K9s for {{ user }}:
  file.managed:
    - makedirs: True
    - name: 'C:\\Users\\{{ known_local_user }}\\{{ k9s_config_dir }}\\config.yaml'
    - require:
      - archive: 'Extract K9s Bundle'
    - source: salt://{{ tplroot }}/files/k9s_config.yaml

Configure K9s Skins for {{ user }}:
  file.recurse:
    - makedirs: True
    - name: 'C:\Users\{{ user }}\{{ k9s_config_dir }}\skins'
    - require:
      - file: 'Ensure K9s Skins Directory Exists'
    - source: salt://{{ tplroot }}/files/skins
{% endfor %}

Ensure K9s Skins Directory Exists:
  file.directory:
    - name: 'C:\Users\Default\{{ k9s_rel_path }}\skins'
    - makedirs: True
    - user: System
    - group: Administrators
    - require:
      - archive: 'Extract K9s Bundle'

Seed K9s Config for Future Users:
  file.managed:
    - group: Administrators
    - makedirs: True
    - name: 'C:\\Users\\Default\\{{ k9s_rel_path }}\\config.yaml'
    - source: salt://{{ tplroot }}/files/k9s_config.yaml
    - user: System

Seed K9s Skins for Future Users:
  file.recurse:
    - makedirs: True
    - name: 'C:\\Users\\Default\\{{ k9s_rel_path }}\\skins'
    - require:
      - file: 'Ensure K9s Skins Directory Exists'
    - source: salt://{{ tplroot }}/files/skins
