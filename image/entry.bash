#!/bin/bash

#ansible-playbook -i inventory -c local test.yml -vv # moved to Docker

service wazuh-manager start
ln -sf /dev/stdout /var/ossec/logs/alerts/alerts.json
#tail --pid $$ -F /var/ossec/logs/alerts/alerts.json
