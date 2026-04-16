# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

{%- set skel_dir = '/etc/skel/.config/k9s' %}

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
    - name: '{{ skel_dir }}'
    - user: root
    - group: root
    - makedirs: True
    - mode: 0755
