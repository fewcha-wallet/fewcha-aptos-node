#!/bin/bash

source "./0-config.sh"

export VALIDATOR_ADDRESS="$(kubectl get svc ${CODENAME}-aptos-node-validator-lb --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')"
export FULLNODE_ADDRESS="$(kubectl get svc ${CODENAME}-aptos-node-fullnode-lb --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')"

aptos genesis set-validator-configuration --keys-dir $(pwd)/keys/${CODENAME} --local-repository-dir $(pwd)/keys/${CODENAME} --username ${CODENAME} --validator-host ${VALIDATOR_ADDRESS}:6180 --full-node-host ${FULLNODE_ADDRESS}:6182
