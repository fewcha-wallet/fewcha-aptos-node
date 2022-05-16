#!/bin/bash

source "./0-config.sh"

aws eks update-kubeconfig --name aptos-${CODENAME} --region ${AWS_REGION}