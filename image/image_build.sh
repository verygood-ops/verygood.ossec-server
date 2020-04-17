#!/usr/bin/env bash
set -e

REGION=${REGION:-"us-west-2"}
ENV_TAG=${ENV_TAG:-"dev.genpop.0"}
SERVICE=$(grep -A1 "services:" docker-compose.yaml|tail -n1|awk '{print $1}'|cut -d":" -f1)

rm -rf verygood.ossec-server
git clone git@github.com:verygood-ops/verygood.ossec-server.git verygood.ossec-server

if [ $BUILD != "" ]
then
    REGION=$REGION ENV_TAG=$ENV_TAG docker-compose -f docker-compose.yaml up --build
    stat=$?
  else
    REGION=$REGION ENV_TAG=$ENV_TAG docker-compose -f docker-compose.yaml up
    stat=$?
fi

rm -rf verygood.ossec-server

if [ $stat -eq 0 ]; then
    echo -e "\nAttempt to publish an image\n"
    ENV_TAG=$ENV_TAG docker-compose push $SERVICE
fi
