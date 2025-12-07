#!/bin/bash

# Exit on error
set -e

echo "===== Building Base Image with DevOps Tools ====="

# Define image name and tag
IMAGE_NAME="devops-base-image"
IMAGE_TAG="latest"
DOCKER_REPO="bndeepti"  # Docker Hub username

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install it first."
    exit 1
fi

# Build the Docker image
echo "Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -f Dockerfile.baseimage .

# Tag the image for the repository
echo "Tagging image for repository: ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}"
docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}

# Push the image to the repository
echo "Pushing image to repository..."
docker push ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}

echo "===== Build and Push Complete ====="
echo "You can now run the image with:"
echo "docker run -it --rm ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}"
echo ""
echo "To use with your application, you can:"
echo "1. Use it as a base image in your Dockerfile:"
echo "   FROM ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}"
echo ""
echo "2. Or mount your application code and run it directly:"
echo "   docker run -it --rm -v \$(pwd):/workspace ${DOCKER_REPO}/${IMAGE_NAME}:${IMAGE_TAG}"