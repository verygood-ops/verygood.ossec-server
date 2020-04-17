#!/usr/bin/env bash
set -e

IMG_TAG=${IMG_TAG:-"0.0.1"}
SERVICE=$(grep -A1 "services:" docker-compose.yaml|tail -n1|awk '{print $1}'|cut -d":" -f1)

rm -rf verygood.ossec-server
git clone git@github.com:verygood-ops/verygood.ossec-server.git verygood.ossec-server
cp -f ../templates/vgs_rules.xml.j2 ./

if [[ -n $BUILD ]]
then
    IMG_TAG=$IMG_TAG docker-compose -f docker-compose.yaml up --build
    stat=$?
  else
    IMG_TAG=$IMG_TAG docker-compose -f docker-compose.yaml up
    stat=$?
fi

rm -rf verygood.ossec-server

if [ $stat -eq 0 ]; then
    echo -e "\nAttempt to publish an image\n"
    IMG_TAG=$IMG_TAG docker-compose push $SERVICE
fi
