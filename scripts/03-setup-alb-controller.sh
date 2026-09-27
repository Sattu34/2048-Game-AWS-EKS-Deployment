#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="game-2048-cluster"
REGION="us-east-1"
SERVICE_ACCOUNT="aws-load-balancer-controller"
POLICY_NAME="AWSLoadBalancerControllerIAMPolicy"
ROLE_NAME="AmazonEKSLoadBalancerControllerRole"

eksctl utils associate-iam-oidc-provider \
  --cluster "$CLUSTER_NAME" \
  --region "$REGION" \
  --approve

curl -Lo /tmp/iam_policy.json \
  https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

aws iam create-policy \
  --policy-name "$POLICY_NAME" \
  --policy-document file:///tmp/iam_policy.json \
  2>/dev/null || true

POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/${POLICY_NAME}"

eksctl create iamserviceaccount \
  --cluster="$CLUSTER_NAME" \
  --region="$REGION" \
  --namespace=kube-system \
  --name="$SERVICE_ACCOUNT" \
  --role-name="$ROLE_NAME" \
  --attach-policy-arn="$POLICY_ARN" \
  --approve \
  --override-existing-serviceaccounts

helm repo add eks https://aws.github.io/eks-charts
helm repo update

VPC_ID=$(aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$REGION" \
  --query 'cluster.resourcesVpcConfig.vpcId' \
  --output text)

helm upgrade --install aws-load-balancer-controller \
  eks/aws-load-balancer-controller \
  --namespace kube-system \
  --set clusterName="$CLUSTER_NAME" \
  --set serviceAccount.create=false \
  --set serviceAccount.name="$SERVICE_ACCOUNT" \
  --set region="$REGION" \
  --set vpcId="$VPC_ID"

kubectl rollout status deployment/aws-load-balancer-controller -n kube-system
