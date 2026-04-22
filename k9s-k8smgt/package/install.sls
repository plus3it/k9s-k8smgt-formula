# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

include:
{%- if grains.kernel == "Linux" %}
  - k9s-k8smgt.package.lin_install
{%- elif grains.kernel == "Windows" %}
  - k9s-k8smgt.package.win_install
{%- endif %}
