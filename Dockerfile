FROM python:3.11-slim

WORKDIR /PERCEPTRONX
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Update and install dependencies with specific flags to avoid errors
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    libffi-dev \
    libssl-dev \
    libc-dev \
    curl \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python packages
COPY Backend/requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY Backend /PERCEPTRONX/Backend
COPY Frontend_Web /PERCEPTRONX/Frontend_Web
COPY Frontend /PERCEPTRONX/Frontend
COPY start.sh /PERCEPTRONX/

# Create uploads directory if it doesn't exist
RUN mkdir -p /PERCEPTRONX/Frontend_Web/static/assets/images/user
RUN chmod -R 777 /PERCEPTRONX/Frontend_Web/static/assets/images/user
RUN chmod +x /PERCEPTRONX/start.sh

WORKDIR /PERCEPTRONX/Backend
EXPOSE 8000

# Use the start script
CMD ["/bin/bash", "/PERCEPTRONX/start.sh"]
