#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="game-2048-cluster"
REGION="us-east-1"
NAMESPACE="game-2048"
PROFILE_NAME="game-2048"

kubectl apply -f kubernetes/namespace.yaml

eksctl create fargateprofile \
  --cluster "$CLUSTER_NAME" \
  --region "$REGION" \
  --name "$PROFILE_NAME" \
  --namespace "$NAMESPACE"
