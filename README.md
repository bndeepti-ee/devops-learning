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

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/health` | GET | Returns the health status of the application with a UTC timestamp |

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
docker build -t devops-learning-app .
```

### Running the Docker Container

Once the image is built, you can run the application in a Docker container:

```
docker run -d -p 8000:8000 --name devops-learning-container devops-learning-app
```

This will:
- Run the container in detached mode (`-d`)
- Map port 8000 of the container to port 8000 on your host (`-p 8000:8000`)
- Name the container "devops-learning-container" (`--name devops-learning-container`)
- Use the "devops-learning-app" image we built earlier

### Accessing the Application

The application will be accessible at `http://localhost:8000`, just like when running it directly with uvicorn.

### Checking Container Logs

You can view the logs from the container with:

```
docker logs devops-learning-container
```

### Stopping the Container

To stop and remove the container:

```
docker stop devops-learning-container && docker rm devops-learning-container
```

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

2. **Build the Docker image**:
   ```
   docker build -t devops-learning-app:latest .
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

You can deploy the entire application to Kubernetes with a single command using the provided script:

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

### Cleanup

Similarly, you can clean up the deployment with a single command:

```
./scripts/cleanup_app.sh
```

This script will:
- Delete all Kubernetes resources
- Stop the Minikube tunnel
- Optionally stop Minikube (based on your choice)
