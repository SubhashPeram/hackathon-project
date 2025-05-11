#!/bin/bash
AWS_REGION="us-west-2"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
for svc in patient-service appointment-service; do
  aws ecr create-repository --repository-name $svc --region $AWS_REGION || true
  echo "$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$svc"
done
