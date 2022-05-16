#!/bin/bash

source "./0-config.sh"

touch ./keys/${CODENAME}/layout.yaml

echo "
---
root_key: "0x5243ca72b0766d9e9cbf2debf6153443b01a1e0e6d086c7ea206eaf6f8043956"
users:
  - ${CODENAME}
chain_id: 23
" > ./keys/${CODENAME}/layout.yaml

cp -r ./framework ./keys/${CODENAME}/framework

aptos genesis generate-genesis --local-repository-dir ./keys/${CODENAME} --output-dir ./keys/${CODENAME}
