#!/bin/bash
TFVARS=`pwd`/terraform.tfvars
cd ../terraform
terraform "$@" -var-file=${TFVARS}

##rename ".tf" ".tmp" attacker*
##rename ".tmp" ".tf" attacker*
