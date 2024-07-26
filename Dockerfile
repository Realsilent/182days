# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set environment variables to avoid Python writing .pyc files to disk
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Install system dependencies required for building Python packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libffi-dev \
    libpq-dev \
    libsndfile1 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    tk-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy only the requirements file to leverage Docker cache
COPY requirements.txt /app/

# Upgrade pip and install dependencies

# Copy the rest of the application code
COPY . /app/

# Command to run the application
CMD ["gunicorn", "app:app"]
