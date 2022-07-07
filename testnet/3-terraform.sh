#!/bin/bash

source "./0-config.sh"

export BACKEND_KEY="state/aptos-node"

terraform init \
  -backend-config="bucket=${CODENAME}" \
  -backend-config="key=${BACKEND_KEY}" \
  -backend-config="region=${AWS_REGION}"

terraform workspace new ${CODENAME}

terraform apply \
  -var="AWS_REGION=${AWS_REGION}" \
  -var="VALIDATOR_NAME=${VALIDATOR_NAME}" \
  -auto-approve
