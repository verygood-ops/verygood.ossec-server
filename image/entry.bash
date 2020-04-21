#!/bin/bash

service wazuh-manager start
echo "Starting push logs to stdout"
tail --pid $$ -F /var/ossec/logs/alerts/alerts.json; wait
# ln -sf /dev/stdout /var/ossec/logs/alerts/alerts.json
