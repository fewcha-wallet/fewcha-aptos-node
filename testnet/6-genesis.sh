#!/bin/bash

source "./0-config.sh"

touch ./keys/${CODENAME}/layout.yaml

echo "
---
root_key: "F22409A93D1CD12D2FC92B5F8EB84CDCD24C348E32B3E7A720F3D2E288E63394"
users:
  - ${CODENAME}
chain_id: 40
min_stake: 0
max_stake: 100000
min_lockup_duration_secs: 0
max_lockup_duration_secs: 2592000
epoch_duration_secs: 86400
initial_lockup_timestamp: 1656615600
min_price_per_gas_unit: 1
allow_new_validators: true" > ./keys/${CODENAME}/layout.yaml

cp -r ./framework ./keys/${CODENAME}/framework

aptos genesis generate-genesis \
  --local-repository-dir ./keys/${CODENAME} \
  --output-dir ./keys/${CODENAME}
