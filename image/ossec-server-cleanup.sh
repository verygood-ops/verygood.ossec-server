#!/usr/bin/env bash
# clean up ossec-agents list on ossec-server

for OUTPUT in $(/var/ossec/bin/agent_control -l | grep -E 'Disconnected|Never' | tr ':' ',' | cut -d "," -f 2 )
do
  /var/ossec/bin/manage_agents -r $OUTPUT
done
