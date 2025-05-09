#!/bin/bash
set -e

echo "Starting application with environment variables:"
echo "MYSQL_HOST: $MYSQL_HOST"
echo "REDIS_HOST: $REDIS_HOST"
echo "MONGO_HOST: $MONGO_HOST"
echo "PORT: $PORT"

mkdir -p /PERCEPTRONX/Frontend_Web/static/assets/images/user
chmod -R 777 /PERCEPTRONX/Frontend_Web/static/assets/images/user

cd /PERCEPTRONX/Backend
exec uvicorn main:app --host 0.0.0.0 --port "${PORT:-8000}" --reload --log-level debug
