#!/bin/bash
set -e

echo "Deploying InfraStore to Kubernetes: "

echo "Creating namespace: "
kubectl apply -f namespace.yaml

echo "Applying secrets and config: "
kubectl apply -f secret.yaml
kubectl apply -f configmap.yaml

echo "Creating persistent volumes: "
kubectl apply -f pvc.yaml

echo "Deploying application: "
kubectl apply -f deployment.yaml

echo "Configuring networking: "
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
kubectl apply -f networkpolicy.yaml
kubectl apply -f resourcequota.yaml

echo "Configuring autoscaling: "
kubectl apply -f hpa.yaml

echo "Waiting for deployment to be ready: "
kubectl rollout status deployment/infrastore -n infrastore

echo "InfraStore deployed successfully."
