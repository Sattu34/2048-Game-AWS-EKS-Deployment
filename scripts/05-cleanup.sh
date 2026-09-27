#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="game-2048-cluster"
REGION="us-east-1"

kubectl delete -f kubernetes/ingress.yaml --ignore-not-found
kubectl delete -f kubernetes/service.yaml --ignore-not-found
kubectl delete -f kubernetes/deployment.yaml --ignore-not-found
kubectl delete -f kubernetes/namespace.yaml --ignore-not-found

eksctl delete cluster --name "$CLUSTER_NAME" --region "$REGION"
