#!/bin/bash
TFVARS=`pwd`/terraform.tfvars
cd ../terraform
terraform "$@" -var-file=${TFVARS}
