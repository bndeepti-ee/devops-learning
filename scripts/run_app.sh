#!/bin/bash

# Exit on error
set -e

echo "===== Devops Learning Application Kubernetes Deployment ====="

# Check if minikube is installed
if ! command -v minikube &> /dev/null; then
    echo "Error: minikube is not installed. Please install it first."
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed. Please install it first."
    exit 1
fi

# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: docker is not installed. Please install it first."
    exit 1
fi

# Start Minikube if it's not running
if ! minikube status &> /dev/null; then
    echo "Starting Minikube..."
    minikube start
else
    echo "Minikube is already running."
fi

# Pull the Docker image
echo "Pulling Docker image..."
docker pull bndeepti/devops-learning:latest

# Load the Docker image into Minikube
echo "Loading Docker image into Minikube..."
minikube image load bndeepti/devops-learning:latest

# Apply Kubernetes configurations
echo "Applying Kubernetes configurations..."
kubectl apply -f k8s/

# Enable the Ingress addon in Minikube if not already enabled
if ! minikube addons list | grep -q "ingress: enabled"; then
    echo "Enabling Ingress addon..."
      minikube addons enable ingress
else
    echo "Ingress addon is already enabled."
fi

# Check if the host entry exists in /etc/hosts
if ! grep -q "127.0.0.1 devops-learning.app" /etc/hosts; then
    echo "Adding devops-learning.app to /etc/hosts..."
    echo "You may be prompted for your password to modify /etc/hosts"
    sudo sh -c 'echo "127.0.0.1 devops-learning.app" | sudo tee -a /etc/hosts > /dev/null'
else
    echo "Host entry for devops-learning.app already exists in /etc/hosts."
fi

# Start the Minikube tunnel in the background
echo "Starting Minikube tunnel in the background..."
# Check if tunnel is already running
if ! ps aux | grep -v grep | grep -q "minikube tunnel"; then
    minikube tunnel > /dev/null 2>&1 &
    TUNNEL_PID=$!
    echo "Minikube tunnel started with PID: $TUNNEL_PID"
    # Give the tunnel a moment to establish
    sleep 5
else
    echo "Minikube tunnel is already running."
fi

# Wait for the deployment to be ready
echo "Waiting for deployment to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/devops-learning

echo "===== Deployment Complete ====="
echo "Your application is now accessible at:"
echo "- http://devops-learning.app/health - Health check endpoint"
echo "- http://devops-learning.app/docs - Swagger UI documentation"
echo ""
echo "To clean up the deployment, run: ./scripts/cleanup_app.sh"