FROM python:3.11-slim
WORKDIR /PERCEPTRONX
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
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

# Copy requirements first to leverage Docker cache
COPY Backend/requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY Backend /PERCEPTRONX/Backend
COPY Frontend_Web /PERCEPTRONX/Frontend_Web
COPY Frontend /PERCEPTRONX/Frontend
COPY init.sql /PERCEPTRONX/
COPY start.sh /PERCEPTRONX/

# Create directories and set permissions
RUN mkdir -p /PERCEPTRONX/Frontend_Web/static/assets/images/user
RUN chmod -R 777 /PERCEPTRONX/Frontend_Web/static/assets/images/user
RUN chmod +x /PERCEPTRONX/start.sh

WORKDIR /PERCEPTRONX
EXPOSE 8000
CMD ["/bin/bash", "/PERCEPTRONX/start.sh"]
