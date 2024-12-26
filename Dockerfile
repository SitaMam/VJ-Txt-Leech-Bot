#FROM python:3.10.8-slim-buster
#RUN apt-get update -y && apt-get upgrade -y \
  #  && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
 #   && apt-get clean \
 #   && rm -rf /var/lib/apt/lists/*

#COPY . /app/
#WORKDIR /app/
#RUN pip3 install --no-cache-dir --upgrade --requirement requirements.txt
#CMD gunicorn app:app & python3 main.py

FROM python:3.10.8-slim-buster

# Update and install required system dependencies
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy application code to container
COPY . /app/
WORKDIR /app/

# Create and activate a Python virtual environment
RUN python3 -m venv /app/venv \
    && . /app/venv/bin/activate \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir --requirement requirements.txt

# Activate the virtual environment and start the application
CMD . /app/venv/bin/activate && gunicorn app:app & python3 main.py
