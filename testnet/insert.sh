#!/bin/bash

source ../../0-config.sh

kubectl create secret generic ${CODENAME}-aptos-node-0-genesis-e2 \
    --from-file=genesis.blob=genesis.blob \
    --from-file=waypoint.txt=waypoint.txt \
    --from-file=validator-identity.yaml=validator-identity.yaml \
    --from-file=validator-full-node-identity.yaml=validator-full-node-identity.yaml
