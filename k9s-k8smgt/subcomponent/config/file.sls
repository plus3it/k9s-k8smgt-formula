# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_config_file }}

k9s-k8smgt-subcomponent-config-file-file-managed:
  file.managed:
    - name: {{ k9s_k8smgt.subcomponent.config }}
    - source: {{ files_switch(['subcomponent-example.tmpl'],
                              lookup='k9s-k8smgt-subcomponent-config-file-file-managed',
                              use_subpath=True
                  )
              }}
    - mode: 644
    - user: root
    - group: {{ k9s_k8smgt.rootgroup }}
    - makedirs: True
    - template: jinja
    - require_in:
      - sls: {{ sls_config_file }}
