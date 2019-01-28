#!/bin/bash
# script update security group to use our new CIDR block ranges for the new building - ssh protocol 

groupID="${1}"

aws ec2 authorize-security-group-ingress --protocol tcp --port 443  --cidr 192.199.183.80/30 --group-id "${groupID}"
aws ec2 authorize-security-group-ingress --protocol tcp --port 443  --cidr 65.158.24.104/30 --group-id "${groupID}"
aws ec2 authorize-security-group-ingress --protocol tcp --port 443  --cidr  204.134.243.168/29 --group-id "${groupID}"
