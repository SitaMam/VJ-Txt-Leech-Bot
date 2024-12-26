FROM python:3.10.8-slim-buster

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/

# Create and activate a virtual environment
RUN python3 -m venv venv
RUN . venv/bin/activate && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

CMD . venv/bin/activate && gunicorn app:app & python3 main.py
