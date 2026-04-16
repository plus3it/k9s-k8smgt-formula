# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

k9s-k8smgt-package-install-pkg-installed:
  pkg.installed:
    - name: {{ k9s_k8smgt.pkg.name }}
