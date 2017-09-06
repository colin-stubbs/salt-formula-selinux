SELinux
=======

Configures SELinux

Available states
================

.. contents::
    :local:

``selinux``
--------

Configures SELinux based on Pillar configuration, e.g.
1. operational mode
2. Installs required packages (CentOS/RHEL at present)
3. Creates /etc/selinux/extra/modules
4. Sets SELinux Booleans to True/False
