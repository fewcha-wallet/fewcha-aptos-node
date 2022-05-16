#!/bin/bash

export VALIDATOR_ADDRESS="$(kubectl get svc testnet-aptos-node-validator-lb --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')"
export FULLNODE_ADDRESS="$(kubectl get svc testnet-aptos-node-fullnode-lb --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')"

echo "Validator node IP: "${VALIDATOR_ADDRESS}
echo "Fullnode node IP: "${FULLNODE_ADDRESS}


