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

## Development

### Project Structure

```
.
├── app/
│   ├── __init__.py
│   ├── main.py          # Application entry point
│   └── routers/         # API route definitions
│       ├── __init__.py
│       └── hello_world.py
├── tests/               # Test directory
│   ├── __init__.py
│   ├── test_main.py
│   └── routers/
│       ├── __init__.py
│       └── test_hello_world.py
├── requirements.txt     # Project dependencies
└── README.md           # Project documentation
```

### Running Tests

```
pytest
```
