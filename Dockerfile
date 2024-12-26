FROM python:3.10.8-slim-buster

# Update and install required system dependencies
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy application files to /app directory
COPY . /app/

# Set the working directory
WORKDIR /app/

# Install dependencies in a virtual environment
RUN python3 -m venv venv \
    && . venv/bin/activate \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Command to start the application
CMD . venv/bin/activate && gunicorn app:app & python3 main.py
