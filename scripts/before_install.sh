#!/bin/bash
set -e

echo "=== Before Install Script ==="
echo "Timestamp: $(date)"

# Actualizar el sistema
echo "Updating system packages..."
yum update -y

# Instalar Node.js si no está instalado
if ! command -v node &> /dev/null; then
    echo "Installing Node.js..."
    curl -sL https://rpm.nodesource.com/setup_18.x | bash -
    yum install -y nodejs
else
    echo "Node.js already installed: $(node --version)"
fi

# Verificar npm
if ! command -v npm &> /dev/null; then
    echo "ERROR: npm is not installed"
    exit 1
else
    echo "npm version: $(npm --version)"
fi

# Crear directorio de la aplicación si no existe
APP_DIR="/home/ec2-user/devops-app"
if [ ! -d "$APP_DIR" ]; then
    echo "Creating application directory: $APP_DIR"
    mkdir -p $APP_DIR
fi

# Limpiar despliegues anteriores
echo "Cleaning up old deployments..."
rm -rf $APP_DIR/*

echo "=== Before Install Completed ==="
