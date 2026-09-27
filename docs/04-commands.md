# Command Reference

## AWS

```bash
aws configure
aws sts get-caller-identity
aws eks update-kubeconfig --region us-east-1 --name game-2048-cluster
```

## EKS

```bash
eksctl create cluster --name game-2048-cluster --region us-east-1 --fargate
eksctl create fargateprofile --cluster game-2048-cluster --region us-east-1 --name game-2048 --namespace game-2048
```

## OIDC

```bash
eksctl utils associate-iam-oidc-provider --cluster game-2048-cluster --region us-east-1 --approve
```

## IAM ServiceAccount

```bash
eksctl create iamserviceaccount \
  --cluster=game-2048-cluster \
  --region=us-east-1 \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name=AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::<ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```

## Helm

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
```

## Kubernetes

```bash
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl apply -f kubernetes/ingress.yaml

kubectl get pods -n game-2048
kubectl get svc -n game-2048
kubectl get ingress -n game-2048
```

## Troubleshooting

```bash
kubectl describe ingress game-2048 -n game-2048
kubectl logs -n kube-system deployment/aws-load-balancer-controller
kubectl describe pod -n game-2048 <pod-name>
kubectl logs -n game-2048 <pod-name>
```
