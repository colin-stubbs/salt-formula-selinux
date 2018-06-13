{# selinux/init.sls #}

{# import mapped variables from defaults, os/os_family based variants, and pillar config #}
{% from "selinux/map.jinja" import selinux_map with context %}

{# installs all packages based on results from within map.jinja #}
selinux-packages:
  pkg.installed:
    - pkgs: {{ selinux_map.lookup.pkgs }}

{# we rely on salt minion grains to indicate if SELinux is available on the minion, if not don't bother trying to configure it #}
{% if grains.selinux is defined and grains.selinux.enabled == True %}

{# controls operational mode, e.g. disabled/permissive/enforcing #}
selinux-mode:
  selinux.mode:
    - name: {{ selinux_map.mode }}
    - require:
      - pkg: selinux-packages

{# relabel file system on next boot #}
selinux-autorelabel:
  file.touch:
    - name: /.autorelabel
    - onchanges:
      - selinux: selinux-mode

{# relabel file system immediately #}
selinux-fixfiles:
  cmd.run:
    - name: fixfiles relabel
    - onchanges:
      - selinux: selinux-mode

{# this dir is not created by default on certain distros, make sure it is #}
selinux-extra-modules-dir:
  file.directory:
    - name: {{ selinux_map.lookup.locations.extra_modules }}
    - makedirs: True
    - user: root
    - group: root
    - mode: 0755
    - require:
      - pkg: selinux-packages

{# set persistent booleans if configured to do so #}
{% if selinux_map.booleans is defined %}
{% for boolean, options in selinux_map.booleans.items() %}
selinux-{{ boolean }}:
  selinux.boolean:
    - name: {{ boolean }}
    - value: {{ options.value|default(True) }}
    - persist: {{ options.persist|default(True) }}
{% endfor %}
{% endif %} {# if selinux_map.booleans is defined #}

{% if selinux_map.modules is defined %}
{% for module, options in selinux_map.modules.items() %}
selinux-module-{{ module }}:
  selinux.module:
    - name: {{ module }}
    {% if options.module_state is defined %}
    - module_state: {{ options.module_state }}
    {% endif %}
    {% if options.version is defined %}
    - version: {{ options.version }}
    {% endif %}
    {% if options.install is defined %}
    - install: {{ options.install }}
    {% if options.source is defined %}
    - source: {{ options.source }}
    {% endif %}
    {% elif options.remove is defined %}
    - remove: {{ options.remove }}
    {% endif %}
{% endfor %}
{% endif %} {# if selinux_map.modules is defined #}

{% endif %} {# if grains.selinux.enabled == True #}

{# EOF #}
