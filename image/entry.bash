#!/bin/bash

service wazuh-manager start
ln -sf /dev/stdout /var/ossec/logs/alerts/alerts.json
