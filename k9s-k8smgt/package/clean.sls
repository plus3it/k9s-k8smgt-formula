# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

include:
  - {{ sls_config_clean }}

k9s-k8smgt-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ k9s_k8smgt.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
