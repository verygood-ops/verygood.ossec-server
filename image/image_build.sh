#!/usr/bin/env bash
set -e

# This script will help to build test/run localy and/or publish ossec-server image to ECR or QUAY regs.
# To login to ECR Registry 'aws --region=us-west-2 ecr get-login --no-include-email'
# To publish to quay.io 'BUILD=1 REG=1 bash image_build.sh'

IMG_TAG=${IMG_TAG:-"0.0.7"}
REPO_NAME=ossec-server
REGION=${AWS_DEFAULT_REGION:-us-west-2}
ACC_ID=$(aws sts get-caller-identity --query Account --output text)
SERVICE=$(grep -A1 "services:" docker-compose.yaml|tail -n1|awk '{print $1}'|cut -d":" -f1)

function check_repo_exists(){
  echo "Check the repo vgs/${REPO_NAME} exists if not create..."
  local CMD="aws --region=$REGION ecr"
  $CMD describe-repositories --repository-names vgs/${REPO_NAME} >/dev/null || \
  $CMD create-repository --repository-name vgs/${REPO_NAME}  
}

[[ -n $BUILD ]] && echo -e "\n Publishing container...\n" || \
                   echo -e "\n Starting container...\n, run 'BUILD=1 bash $0' in case wanted to build & publish"
[[ -n $REG ]] && export REGISTRY="quay.io/verygoodsecurity/${REPO_NAME}" || \
                 export REGISTRY="${ACC_ID}.dkr.ecr.${REGION}.amazonaws.com/vgs/${REPO_NAME}"; check_repo_exists

rm -rf verygood.ossec-server
git clone git@github.com:verygood-ops/verygood.ossec-server.git verygood.ossec-server

function publish() {
  if [ $stat -eq 0 ]; then
    echo -e "\n Attempt to publish an image...\n"
    IMG_TAG=$IMG_TAG REGISTRY=$REGISTRY docker-compose push $SERVICE
  fi
}

if [[ -n $BUILD ]]; then
    IMG_TAG=$IMG_TAG REGISTRY=$REGISTRY docker-compose -f docker-compose.yaml build
    stat=$?; publish
  else
    IMG_TAG=$IMG_TAG REGISTRY=$REGISTRY docker-compose -f docker-compose.yaml up
fi

rm -rf verygood.ossec-server