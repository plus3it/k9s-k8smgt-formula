# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

k9s-k8smgt-config-file-file-managed:
  file.managed:
    - name: {{ k9s_k8smgt.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='k9s-k8smgt-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ k9s_k8smgt.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        k9s_k8smgt: {{ k9s_k8smgt | json }}
