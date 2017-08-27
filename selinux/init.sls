{% from "selinux/map.jinja" import selinux_map with context %}

{{ selinux_map.mode }}

policycoreutils-python:
  pkg.installed:
    - name: policycoreutils-python

libselinux:
  pkg.installed:
    - name: libselinux

libselinux-python:
  pkg.installed:
    - name: libselinux-python

libselinux-utils:
  pkg.installed:
    - name: libselinux-utils

selinux-policy:
  pkg.installed:
    - name: selinux-policy

checkpolicy:
  pkg.installed:
    - name: checkpolicy

selinux-policy-targeted:
  pkg.installed:
    - name: selinux-policy-targeted

extra_modules_dir:
  file.directory:
    - name: /etc/selinux/extra/modules
    - makedirs: True
    - user: root
    - group: root
    - mode: 0755
    - require:
      - pkg: selinux-policy

{% for boolean, value in selinux_map.booleans.items() %}
{{ boolean }}:
  selinux.boolean:
    - value: {{ value }}
    - persist: True
{% endfor %}
