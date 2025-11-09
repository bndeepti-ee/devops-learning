#!/bin/bash

# Exit on error
set -e

echo "===== Cleaning up FastAPI Application Kubernetes Deployment ====="

echo "Deleting Kubernetes resources..."
kubectl delete -f k8s/ || echo "No resources to delete or already deleted."

echo "Stopping Minikube tunnel..."
pkill -f "minikube tunnel" || echo "Minikube tunnel is not running."

echo "===== Cleanup Complete ====="