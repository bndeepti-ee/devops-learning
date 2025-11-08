#!/bin/bash

# Exit on error
set -e

echo "===== Cleaning up FastAPI Application Kubernetes Deployment ====="

# Delete Kubernetes resources
echo "Deleting Kubernetes resources..."
kubectl delete -f k8s/ || echo "No resources to delete or already deleted."

# Stop the Minikube tunnel
echo "Stopping Minikube tunnel..."
pkill -f "minikube tunnel" || echo "Minikube tunnel is not running."

# Ask if user wants to stop Minikube
#read -p "Do you want to stop Minikube? (y/n): " STOP_MINIKUBE
#if [[ $STOP_MINIKUBE == "y" || $STOP_MINIKUBE == "Y" ]]; then
#    echo "Stopping Minikube..."
#    minikube stop
#else
#    echo "Minikube is still running."
#fi

echo "===== Cleanup Complete ====="