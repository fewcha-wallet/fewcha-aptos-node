#!/bin/bash

source "./0-config.sh"

cp ./insert.sh ./keys/${CODENAME}/insert.sh

cd ./keys/${CODENAME} && sh insert.sh

kubectl rollout restart deploy
