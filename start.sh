#!/bin/bash
set -e

# Wait for MySQL to be available (if connecting to external MySQL)
echo "Waiting for services to be available..."
sleep 10

# Start your application
cd /PERCEPTRONX/Backend
python main.py
