# Use Python 3.11 as the base image
FROM python:3.11-slim

# Set working directory in the container
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
# --no-cache-dir prevents storing the package cache, reducing image size
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
# Copy everything from current directory to /app in container
COPY . /app/

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application using uvicorn directly
# --host 0.0.0.0 binds to all network interfaces, making the app accessible from outside the container
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]