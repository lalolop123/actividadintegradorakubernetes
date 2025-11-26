#!/bin/bash

echo "=== Application Stop Script ==="
echo "Timestamp: $(date)"

# Buscar y detener el proceso de Node.js si existe
PID=$(pgrep -f "node app.js" || echo "")

if [ -z "$PID" ]; then
    echo "No running application found"
else
    echo "Stopping application with PID: $PID"
    kill -9 $PID || true
    sleep 2
    echo "Application stopped"
fi

# Limpiar archivos de log antiguos (opcional)
LOG_DIR="/home/ec2-user/devops-app/logs"
if [ -d "$LOG_DIR" ]; then
    echo "Cleaning old logs..."
    find $LOG_DIR -name "*.log" -mtime +7 -delete || true
fi

echo "=== Application Stop Completed ==="