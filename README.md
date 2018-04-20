SELinux
=======

Configures SELinux based on pillar configuration using Salt's selinux state modules,

https://docs.saltstack.com/en/latest/ref/states/all/salt.states.selinux.html

Available States
================

``selinux``
--------

Configures SELinux based on Pillar configuration, e.g.
1. Installs required packages (CentOS/RHEL at present)
2. Ensures essential directories are created which might not be dependent upon distro packages

``selinux.mode``
--------

Configures SELinux based on Pillar configuration, e.g.
1. Operational mode, e.g. permissive/enforcing/disabled

``selinux.booleans``
--------

Configures SELinux based on Pillar configuration, e.g.
1. Sets SELinux Booleans to permanent True/False

``selinux.modules``
--------

Configures SELinux based on Pillar configuration, e.g.
1. Installs or removes SELinux modules

``selinux.fcontext_policy``
--------

Configures SELinux based on Pillar configuration, e.g.
1. Configures SELinux file context policies
