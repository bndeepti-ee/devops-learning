# API Metrics with Prometheus and Grafana

This document explains how to use the metrics system implemented in our application.

## Overview

The application has been instrumented with Prometheus metrics to track:

1. Health check endpoint calls specifically
2. Request processing time (with histogram for percentile analysis)

These metrics are exposed via a `/metrics` endpoint and can be visualized using Grafana.

## Available Metrics

- `health_check_requests_total` - Counter specifically tracking calls to the health check endpoint
- `request_processing_seconds` - Histogram tracking request processing time with labels for method and endpoint

## Local Setup

### Prerequisites

- Docker and Docker Compose installed on your machine

### Starting the Stack

1. Start the entire stack (API, Prometheus, and Grafana):

```bash
docker-compose up -d
```

2. Access the services:
   - FastAPI application: http://localhost:8000
   - Prometheus: http://localhost:9090
   - Grafana: http://localhost:3000 (login with admin/admin)

### Testing the Metrics

1. Make some API calls to generate metrics:

```bash
curl http://localhost:8000/health
```

2. View raw metrics:

```bash
curl http://localhost:8000/metrics
```

## Using Grafana

A pre-configured dashboard has been set up in Grafana with the following panels:

1. **Health Check Requests** - Shows the total number of health check requests over time
3. **Request Processing Time** - Shows the 95th percentile of request processing time

### Accessing the Dashboard

1. Open Grafana at http://localhost:3000
2. Login with username `admin` and password `admin`
3. Navigate to Dashboards → Devops Learning Metrics Dashboard

## Extending the Dashboard

You can extend the Grafana dashboard by:

1. Logging into Grafana
2. Editing the existing dashboard
3. Adding new panels based on your metrics
4. Saving the updated dashboard

For production use, consider exporting the updated dashboard JSON and adding it to version control.