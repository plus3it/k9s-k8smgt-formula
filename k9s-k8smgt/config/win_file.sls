# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{% set k9s_rel_path = 'AppData\\Local\\k9s' %}

{% for known_local_user in k9s_k8smgt.config.initial_users %}
Configure K9s for {{ known_local_user }}:
  file.managed:
    - makedirs: True
    - name: 'C:\\Users\\{{ known_local_user }}\\{{ k9s_rel_path }}\\config.yaml'
    - require:
      - archive: 'Extract K9s Bundle'
    - source: salt://{{ tplroot }}/files/config.yaml

Configure K9s Skins for {{ known_local_user }}:
  file.recurse:
    - makedirs: True
    - name: 'C:\\Users\\{{known_local_user }}\\{{ k9s_rel_path }}\\skins'
    - require:
      - file: 'Ensure K9s Skins Directory Exists'
    - source: salt://{{ tplroot }}/files/skins
{% endfor %}

{%- for skin_url in k9s_k8smgt.config.skins %}
{%- set skin_name = skin_url.split('/')[-1] %}
Download K9s Skin {{ skin_name }}:
  file.managed:
    - name: 'C:\\Users\\Default\\{{ k9s_rel_path }}\\skins\\{{ skin_name }}'
    - source: {{ skin_url }}
    - skip_verify: True
    - ignore_errors: True
    - require:
      - file: 'Ensure K9s Skins Directory Exists'
    - require_in:
      - file: Seed K9s Skins for Future Users

Notify Failure for {{ skin_name }}:
  test.configurable_test_state:
    - name: 'Skin Download Alert'
    - comment: |
        --------------------------------------------------
        SKIN DOWNLOAD WARNING:
        ----------------------
          The requested URI

            {{ skin_url }}

          returned an error and could not be cached.
          Ensure the URI is correct and reachable from
          this host and update inputs as necessary.
        --------------------------------------------------
    - result: True
    - onfail:
      - file: Download K9s Skin {{ skin_name }}
{%- endfor %}

Ensure K9s Skins Directory Exists:
  file.directory:
    - name: 'C:\\Users\\Default\\{{ k9s_rel_path }}\\skins'
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
    - source: salt://{{ tplroot }}/files/config.yaml
    - user: System

Seed K9s Skins for Future Users:
  file.recurse:
    - exclude_pat:
      - '.gitkeep'
    - makedirs: True
    - name: 'C:\\Users\\Default\\{{ k9s_rel_path }}\\skins'
    - require:
      - file: 'Ensure K9s Skins Directory Exists'
    - source: salt://{{ tplroot }}/files/skins
