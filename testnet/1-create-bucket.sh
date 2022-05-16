#!/bin/bash

source "./0-config.sh"


if [ ${AWS_REGION} == "us-east-1" ]
then
aws s3api create-bucket --bucket ${CODENAME}
else
aws s3api create-bucket --bucket ${CODENAME} --create-bucket-configuration LocationConstraint=${AWS_REGION}
fi


