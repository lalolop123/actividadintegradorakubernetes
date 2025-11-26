#!/bin/bash
set -e

echo "=== After Install Script ==="
echo "Timestamp: $(date)"

APP_DIR="/home/ec2-user/devops-app"
cd $APP_DIR

# Instalar dependencias de Node.js
echo "Installing Node.js dependencies..."
npm install --production

# Verificar que los archivos necesarios existen
if [ ! -f "app.js" ]; then
    echo "ERROR: app.js not found!"
    exit 1
fi

if [ ! -f "package.json" ]; then
    echo "ERROR: package.json not found!"
    exit 1
fi

echo "Application files verified successfully"
echo "Files in directory:"
ls -la $APP_DIR

echo "=== After Install Completed ==="