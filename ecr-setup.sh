#!/bin/bash

AWS_REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Create ECR repositories
aws ecr create-repository --repository-name patient-service --region $AWS_REGION
aws ecr create-repository --repository-name appointment-service --region $AWS_REGION

# Output repository URIs
echo "ECR Repositories:"
echo "$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/patient-service"
echo "$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/appointment-service"
