# Prerequisites

Install and configure:

- AWS CLI
- kubectl
- eksctl
- Helm

## AWS CLI

Configure credentials:

```bash
aws configure
aws sts get-caller-identity
```

## kubectl

kubectl is the Kubernetes command-line client used to inspect and manage Kubernetes resources.

```bash
kubectl version --client
```

## eksctl

eksctl is used to create and manage Amazon EKS clusters.

```bash
eksctl version
```

## Helm

Helm installs the AWS Load Balancer Controller.

```bash
helm version
```

The AWS identity used for setup needs permissions to create/manage the AWS resources required by this project.
