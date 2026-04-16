# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as k9s_k8smgt with context %}

include:
{%- if grains.kernel == "Linux" %}
  - k9s-k8smgt.config.lin_clean
{%- elif grains.kernel == "Windows" %}
  - k9s-k8smgt.config.win_clean
{%- endif %}

