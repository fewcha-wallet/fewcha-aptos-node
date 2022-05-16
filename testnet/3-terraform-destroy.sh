#!/bin/bash

source "./0-config.sh"

terraform apply -destroy \
  -var="AWS_REGION=${AWS_REGION}" \
  -var="VALIDATOR_NAME=${VALIDATOR_NAME}" \
  -auto-approve
