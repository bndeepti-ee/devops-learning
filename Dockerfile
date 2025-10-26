# Stage 1: Build dependencies
FROM python:3.11-slim AS builder

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Create a non-root user to run the application
# --disabled-password: Don't assign a password, making the account more secure
# --gecos "": Skip the need for additional user information (full name, room number, etc.)
# appuser: The name of the user account being created
RUN adduser --disabled-password --gecos "" appuser

# Copy installed packages from builder stage
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy only the application code
COPY ./app /app/app

# Change ownership of the application files to the non-root user
# This ensures the user has proper permissions to access the files
RUN chown -R appuser:appuser /app

# Switch to non-root user for all subsequent commands
# This is a key security practice - containers should not run as root
USER appuser

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application using uvicorn directly
# --host 0.0.0.0 binds to all network interfaces, making the app accessible from outside the container
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]