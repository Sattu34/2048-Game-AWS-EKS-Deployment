# Deployment Flow

Run the project in this order.

## 1. Create EKS

```bash
./scripts/01-create-eks.sh
```

Creates the EKS cluster and configures kubectl.

## 2. Create Fargate Profile

```bash
./scripts/02-create-fargate-profile.sh
```

Maps the `game-2048` namespace to AWS Fargate.

## 3. Configure OIDC, IAM/IRSA and ALB Controller

```bash
./scripts/03-setup-alb-controller.sh
```

Identity chain:

```text
Kubernetes ServiceAccount
        |
        v
EKS OIDC Provider
        |
        v
IAM Role
        |
        v
IAM Policy
        |
        v
AWS API permissions
```

The ServiceAccount identifies the controller workload. OIDC establishes trust. The IAM role provides the AWS identity, and the IAM policy defines permissions.

## 4. Deploy 2048

```bash
./scripts/04-deploy-2048.sh
```

The Deployment creates Pods, the ClusterIP Service provides stable internal networking, and the Ingress defines the ALB routing.

## 5. Verify

```bash
kubectl get pods -n game-2048
kubectl get svc -n game-2048
kubectl get ingress -n game-2048
kubectl describe ingress game-2048 -n game-2048
```

The Ingress should eventually show an AWS ALB hostname.

## 6. Cleanup

```bash
./scripts/05-cleanup.sh
```
