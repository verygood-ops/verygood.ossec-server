#!/usr/bin/env bash
set -e

IMG_TAG=${IMG_TAG:-"0.0.7"}
REGION=${AWS_DEFAULT_REGION:-us-west-2}
ACC_ID=$(aws sts get-caller-identity --query Account --output text)
SERVICE=$(grep -A1 "services:" docker-compose.yaml|tail -n1|awk '{print $1}'|cut -d":" -f1)

[[ -n $BUILD ]] && echo "Publishing container...\n" || echo "Starting container...\n, run 'BUILD=1 bash $0' in case wanted to build & publish"
[[ -n $REG ]] && REGISTRY="quay.io/verygoodsecurity/ossec-server" || REGISTRY="${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com/vgs/ossec-server" 


rm -rf verygood.ossec-server
git clone git@github.com:verygood-ops/verygood.ossec-server.git verygood.ossec-server

function publish() {
  if [ $stat -eq 0 ]; then
    echo -e "\nAttempt to publish an image\n"
    IMG_TAG=$IMG_TAG REGISTRY=$REGISTRY docker-compose push $SERVICE
  fi
}

if [[ -n $BUILD ]]; then
    IMG_TAG=$IMG_TAG REGISTRY=$REGISTRY docker-compose -f docker-compose.yaml build
    stat=$?
    publish
  else
    IMG_TAG=$IMG_TAG REGISTRY=$REGISTRY docker-compose -f docker-compose.yaml up
fi

rm -rf verygood.ossec-server
