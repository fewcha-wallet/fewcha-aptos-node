#!/bin/bash

source "./0-config.sh"

mkdir ./keys/${CODENAME}
aptos genesis generate-keys --output-dir ./keys/${CODENAME}
