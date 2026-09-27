#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="game-2048-cluster"
REGION="us-east-1"

eksctl create cluster \
  --name "$CLUSTER_NAME" \
  --region "$REGION" \
  --fargate

aws eks update-kubeconfig \
  --region "$REGION" \
  --name "$CLUSTER_NAME"

kubectl get nodes
