#!/bin/bash
set -e

echo "Deploying InfraStore to Kubernetes: "

echo "Creating namespace: "
kubectl apply -f manifests/namespace.yaml

echo "Applying secrets and config: "
kubectl apply -f manifests/secret.yaml
kubectl apply -f manifests/configmap.yaml

echo "Creating persistent volumes: "
kubectl apply -f manifests/pvc.yaml

echo "Deploying application: "
kubectl apply -f manifests/deployment.yaml

echo "Configuring networking: "
kubectl apply -f manifests/service.yaml
kubectl apply -f manifests/ingress.yaml
kubectl apply -f manifests/networkpolicy.yaml
kubectl apply -f manifests/resourcequota.yaml

echo "Configuring autoscaling: "
kubectl apply -f manifests/hpa.yaml

echo "Waiting for deployment to be ready: "
kubectl rollout status deployment/infrastore -n infrastore

echo "InfraStore deployed successfully."
