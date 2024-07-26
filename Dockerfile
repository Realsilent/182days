# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set environment variables to avoid Python writing .pyc files to disk
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies for Tkinter and other packages
RUN apt-get update && \
    apt-get install -y \
    libtk8.6 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy only the requirements file to leverage Docker cache
COPY requirements.txt /app/

# Upgrade pip and install dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app/

# Command to run the application
CMD ["gunicorn", "app:app"]
