# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{#- Define Linux-specific paths #}
{%- set skel_dir = '/etc/skel/.config/k9s' %}
{%- set skins_dir = skel_dir ~ '/skins' %}

{%- set k9s_config = k9s_k8smgt.get('config', {}) %}
{%- set skins_map = k9s_config.get('skins', {}) if k9s_config is mapping else {} %}

Deploy K9S skeleton config:
  file.managed:
    - group: root
    - mode: 0644
    - name: '{{ skel_dir }}/config.yaml'
    - require:
      - file: 'Ensure existence of K9S skeleton directory'
    - source: salt://k9s-k8smgt/files/config.yaml
    - user: root

Ensure existence of K9S skeleton directory:
  file.directory:
    - group: root
    - makedirs: True
    - mode: 0755
    - name: '{{ skel_dir }}'
    - user: root

Ensure existence of K9S skins skeleton directory:
  file.directory:
    - group: root
    - makedirs: True
    - mode: 0755
    - name: '{{ skins_dir }}'
    - require:
      - file: 'Ensure existence of K9S skeleton directory'
    - user: root

{%- for skin_id, skin_url in skins_map.items() %}
{%- set skin_filename = skin_id ~ '.yaml' %}
Download K9s Skin {{ skin_id }} to Skel:
  file.managed:
    - group: root
    - mode: 644
    - name: {{ skins_dir }}/{{ skin_filename }}
    - require:
      - file: 'Ensure existence of K9S skins skeleton directory'
    - skip_verify: True
    - source: {{ skin_url }}
    - user: root

Notify Failure for {{ skin_id }}:
  test.configurable_test_state:
    - comment: |
        --------------------------------------------------
        SKIN DOWNLOAD WARNING:
        ----------------------
        The skin '{{ skin_id }}' failed to download to the
        '/etc/skel' folder-tree. Ensure the URI is correct
        and reachable.
        Skin URI: '{{ skin_url }}'
        --------------------------------------------------
    - name: 'Skin Download Alert'
    - onfail:
      - file: 'Download K9s Skin {{ skin_id }} to Skel'
    - result: True
{%- endfor %}
