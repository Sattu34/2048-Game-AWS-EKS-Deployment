# Architecture

## Application Traffic

```text
User / Browser
      |
      v
Internet-facing Application Load Balancer
      |
      v
Kubernetes Ingress
      |
      v
ClusterIP Service
      |
      +------------+
      |            |
      v            v
  2048 Pod     2048 Pod
      |            |
      +------------+
           |
           v
       AWS Fargate
           |
           v
       Amazon EKS
```

## Controller Identity

```text
AWS Load Balancer Controller
            |
            v
Kubernetes ServiceAccount
            |
            v
       EKS OIDC
            |
            v
         IAM Role
            |
            v
       IAM Policy
            |
            v
        AWS APIs
```

The Service provides stable networking to Pods. The Ingress defines HTTP routing. The AWS Load Balancer Controller watches the Ingress and reconciles it into an AWS Application Load Balancer.

Fargate runs the application Pods without requiring EC2 worker-node management for this workload.
