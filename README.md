# Ansible OSSEC-wazuh Role

[![Circle CI](https://circleci.com/gh/verygood-ops/verygood.ossec-server.svg?style=svg)](https://circleci.com/gh/verygood-ops/verygood.ossec-server)

An Ansible Role that installs [OSSEC-wazuh](https://github.com/wazuh/ossec-wazuh)

## Molecule

molecule default directories structure can be created with commands:
```
molecule init scenario --scenario-name default --role-name verygood.ossec-server
molecule init role --role-name verygood.ossec-server
```

## Requirements

This role will work on Ubuntu. OSSEC doesn't do SMTP auth of any kind
so if you want email alerts you should add local SMTP like sendmail.

## Role Variables

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

## Example Playbook
----------------

    - hosts: servers
      vars:
        ossec_email_from: foo@example.org
        ossec_email_to: you@example.org
      roles:
         - verygood.ossec-server

## FAQ

Official FAQ: http://ossec.github.io/docs/faq/index.html

Q: ossec-syscheckd(1210): ERROR: Queue '/var/ossec/queue/ossec/queue' not accessible: 'Connection refused'.
A: check that agent has ben registered on the server, see contents of `/var/ossec/etc/client.keys` on agent and server, latest field is a key, it  should be the same


## License

BSD
