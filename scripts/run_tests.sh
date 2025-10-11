#!/bin/bash

# Create directories for reports if they don't exist
mkdir -p reports/coverage
mkdir -p reports/tests

# Run pytest with coverage and generate reports
pytest \
    --cov=app \
    --cov-report=html:reports/coverage \
    --html=reports/tests/report.html \
    --self-contained-html \
    tests/

echo "Tests completed!"
echo "HTML report available at: reports/tests/report.html"
echo "Coverage report available at: reports/coverage/index.html"