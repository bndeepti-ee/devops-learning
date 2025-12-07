# FastAPI Application

A simple FastAPI application with RESTful endpoints.

## Overview

This project is a FastAPI-based API that provides various endpoints for learning purposes.

## Getting Started

### Prerequisites

- Python 3.7+
- pip

### Installation

1. Clone the repository
2. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

### Running the Application

```
uvicorn app.main:app --reload
```

The application will be available at `http://localhost:8000`.

## API Documentation

FastAPI automatically generates interactive API documentation. Once the application is running, you can access:

- **Swagger UI**: [http://localhost:8000/docs](http://localhost:8000/docs)
- **ReDoc**: [http://localhost:8000/redoc](http://localhost:8000/redoc)

These documentation pages are automatically generated based on your API routes and include:
- Interactive endpoint testing
- Request/response schema information
- Authentication requirements (if configured)
- Detailed descriptions from docstrings

## Available Endpoints

| Endpoint  | Method | Description                                                       |
|-----------|--------|-------------------------------------------------------------------|
| `/health` | GET | Returns the health status of the application with a UTC timestamp |
| `/docs`   | GET | Returns the swagger documentation                              |

## Development

### Running Tests

You can run tests using pytest:

```
pytest
```

For generating test reports with coverage:

```
./scripts/run_tests.sh
```

This will generate:
- HTML test reports at `reports/tests/report.html`
- Coverage reports at `reports/coverage/index.html`

## Docker

### Building the Docker Image

You can build a Docker image for this application using the provided Dockerfile:

```
docker build -t devops-learning .
```

### Running the Docker Container

Once the image is built, you can run the application in a Docker container:

```
docker run -d -p 8000:8000 --name devops-learning devops-learning
```

This will:
- Run the container in detached mode (`-d`)
- Map port 8000 of the container to port 8000 on your host (`-p 8000:8000`)
- Name the container "devops-learning" (`--name devops-learning`)
- Use the `devops-learning` image we built earlier

### Accessing the Application

The application will be accessible at `http://localhost:8000`, just like when running it directly with uvicorn.

### Checking Container Logs

You can view the logs from the container with:

```
docker logs devops-learning
```

### Stopping the Container

To stop and remove the container:

```
docker stop devops-learning && docker rm devops-learning
```

## DevOps Base Image

This project includes a base Docker image with all the necessary DevOps tools pre-installed, making it easy to run your application in any environment.

### Included Tools

- Docker
- kubectl
- Helm
- Minikube (with ingress addon enabled)

### Building the Base Image

You can build the base image using the provided script:

```
./scripts/build_base_image.sh
```

This will:
- Build the Docker image with all required tools
- Tag the image for your repository
- Push the image to your Docker repository

### Using the Base Image

You can use the base image in two ways:

1. **As a base for your application Dockerfile**:
   ```dockerfile
   FROM bndeepti/devops-base-image:latest
   
   # Add your application-specific instructions here
   ```

2. **As a development environment**:
   ```bash
   docker run -it --rm -v $(pwd):/workspace bndeepti/devops-base-image:latest
   ```
   This will mount your current directory to the container's workspace directory.

## Kubernetes Deployment

### Prerequisites

- minikube
- kubectl
- docker

### Deploying to Minikube

1. **Start Minikube**:
   ```
   minikube start
   ```

2. **Pull the Docker image and Load to Minikube**:
   ```
   docker pull bndeepti/devops-learning:latest
   minikube image load devops-learning:latest
   ```

3. **Apply the Kubernetes configurations**:
   ```
   kubectl apply -f k8s/
   ```

4. **Enable the Ingress addon in Minikube**:
   ```
   minikube addons enable ingress
   ```

5. **Add the hostname to your hosts file**:
   
   Add the following line to your `/etc/hosts` file:
   ```
   127.0.0.1 devops-learning.app
   ```

6. **Start the Minikube tunnel** (in a separate terminal):
   ```
   minikube tunnel
   ```

7. **Access the application**:
   
   The application will be accessible at:
   - http://devops-learning.app/health - Health check endpoint
   - http://devops-learning.app/docs - Swagger UI documentation

### Cleaning Up

1. **Delete the Kubernetes resources**:
   ```
   kubectl delete -f k8s/
   ```

2. **Stop the Minikube tunnel** (press Ctrl+C in the terminal running the tunnel)

3. **Stop Minikube** (optional):
   ```
   minikube stop
   ```

## Automation Scripts

For convenience, this project includes automation scripts to simplify the deployment and cleanup process:

### Deployment

You can deploy the k8s application to Kubernetes with a single command:

```
./scripts/run_app.sh
```

This script automates all the steps mentioned above, including:
- Starting Minikube if needed
- Building the Docker image
- Applying Kubernetes configurations
- Enabling the Ingress addon
- Setting up host entries
- Starting the Minikube tunnel
- Waiting for the deployment to be ready

You can deploy the helm application to Kubernetes with a single command:

```
helm install devops-learning helm
```

### Cleanup

Similarly, you can clean up the k8s deployment with a single command:

```
./scripts/cleanup_app.sh
```

And you can cleanup the helm deployment with a single command:

```
helm uninstall devops-learning
```

This script will:
- Delete all Kubernetes resources
- Stop the Minikube tunnel
- Optionally stop Minikube (based on your choice)
