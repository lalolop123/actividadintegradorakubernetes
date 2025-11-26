#!/bin/bash
set -e

echo "=== Application Start Script ==="
echo "Timestamp: $(date)"

APP_DIR="/home/ec2-user/devops-app"
cd $APP_DIR

# Crear directorio de logs si no existe
mkdir -p logs

# Configurar variables de entorno
export NODE_ENV=production
export PORT=3000

# Iniciar la aplicación en segundo plano
echo "Starting Node.js application..."
nohup node app.js > logs/app.log 2>&1 &

# Guardar el PID
echo $! > app.pid

# Esperar unos segundos para verificar que la app inició correctamente
sleep 5

# Verificar que el proceso está corriendo
if pgrep -f "node app.js" > /dev/null; then
    echo "Application started successfully!"
    PID=$(pgrep -f "node app.js")
    echo "Process ID: $PID"
    
    # Verificar endpoint
    echo "Checking application health..."
    for i in {1..10}; do
        if curl -f http://localhost:3000/health > /dev/null 2>&1; then
            echo "✓ Application is healthy and responding"
            exit 0
        fi
        echo "Waiting for application to be ready... (attempt $i/10)"
        sleep 3
    done
    
    echo "WARNING: Application started but health check failed"
    exit 0
else
    echo "ERROR: Application failed to start"
    cat logs/app.log
    exit 1
fi

echo "=== Application Start Completed ==="