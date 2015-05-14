Role Name
=========

This roles setup a OSSEC Server

Requirements
------------

This role will work on Ubuntu.

Role Variables
--------------

The role uses the Ubuntu package defaults. The below all the options with their defaults as examples, but list items are truncated. Please view `defaults/main.yml` for a full list.

Email

```yml
ossec_email_to: admin@example.org
ossec_smtp_server: localhost
ossec_email_from: admin@example.org
```

Rules

```yml
ossec_rules:
  - rules_config.xml
```

Syscheck

```yml
ossec_syscheck_frequency: 7200
ossec_syscheck_directories:
  - check_all: yes
    directories: /etc,/usr/bin,/usr/sbin
ossec_syscheck_ignore_directories:
  - /etc/mtab
```

Rootcheck

```yml
ossec_rootcheck_rootkit_files: /var/ossec/etc/shared/rootkit_files.txt
ossec_rootcheck_rootkit_rojans: /var/ossec/etc/shared/rootkit_trojans.txt
```

Global whitelist

```yml
ossec_global_white_lists:
  - 127.0.0.1
```

Remote
```yml
ossec_remote_connection: secure
ossec_remote_port: 1514
ossec_remote_protocol: udp
ossec_remote_local_ip: 0.0.0.0
```

Alerts

```yml
ossec_alerts_log_alert_level: 1
ossec_alerts_email_alert_level: 7
```
Commands

```yml
ossec_commands:
  - name: host-deny
    executable: host-deny.sh
    expect: srcip
    timeout_allowed: yes
```

Active Responses

```yml
ossec_active_responses:
  - command: host-deny
    location: local
    level: 6
    timeout: 600
```

Localfile

```yml
ossec_localfile:
  - log_format: syslog
    location: /var/log/messages
```

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
