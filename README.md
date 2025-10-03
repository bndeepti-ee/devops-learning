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
| `/hello` | GET | Returns a "Hello World" message |
| `/health` | GET | Returns the health status of the application with a UTC timestamp |

## Development

### Running Tests

```
pytest
```

## Docker

### Building the Docker Image

You can build a Docker image for this application using the provided Dockerfile:

```
docker build -t fastapi-app .
```

### Running the Docker Container

Once the image is built, you can run the application in a Docker container:

```
docker run -d -p 8000:8000 --name fastapi-container fastapi-app
```

This will:
- Run the container in detached mode (`-d`)
- Map port 8000 of the container to port 8000 on your host (`-p 8000:8000`)
- Name the container "fastapi-container" (`--name fastapi-container`)
- Use the "fastapi-app" image we built earlier

### Accessing the Application

The application will be accessible at `http://localhost:8000`, just like when running it directly with uvicorn.

### Checking Container Logs

You can view the logs from the container with:

```
docker logs fastapi-container
```

### Stopping the Container

To stop and remove the container:

```
docker stop fastapi-container && docker rm fastapi-container
```
