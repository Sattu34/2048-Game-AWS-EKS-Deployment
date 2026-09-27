#!/usr/bin/env bash
set -euo pipefail

kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/ingress.yaml

kubectl get pods -n game-2048
kubectl get svc -n game-2048
kubectl get ingress -n game-2048
