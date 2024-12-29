#!/bin/bash

# Variables de configuración
LISTMONK_DIR="$HOME/listmonk"
DOCKER_COMPOSE_URL="https://raw.githubusercontent.com/knadh/listmonk/master/docker-compose.yml"
LISTMONK_PORT=9000

# Actualizar el sistema
echo "[INFO] Actualizando el sistema..."
apt update && apt upgrade -y

# Instalar Docker
echo "[INFO] Instalando Docker..."
apt install -y docker.io

# Docker Compose manualmente instalado
echo "[INFO] Docker Compose está instalado manualmente como docker-compose."

# Crear directorio para Listmonk
echo "[INFO] Creando directorio para Listmonk en $LISTMONK_DIR..."
mkdir -p "$LISTMONK_DIR" && cd "$LISTMONK_DIR"

# Descargar docker-compose.yml de Listmonk
echo "[INFO] Descargando docker-compose.yml..."
curl -O "$DOCKER_COMPOSE_URL"

# Iniciar los contenedores
echo "[INFO] Iniciando Listmonk con Docker Compose..."
docker-compose up -d

# Inicializar la base de datos
echo "[INFO] Configurando la base de datos para Listmonk..."
docker-compose exec app ./listmonk --install

# Obtener la dirección IP del servidor
SERVER_IP=$(hostname -I | awk '{print $1}')

# Mostrar información de acceso
echo "[INFO] Instalación completada. Accede a Listmonk utilizando la siguiente información:"
echo "--------------------------------------------------------------"
echo "URL: http://$SERVER_IP:$LISTMONK_PORT"
echo "Usuario: admin"
echo "Contraseña: listmonk"
echo "--------------------------------------------------------------"

# Verificar estado de los contenedores
echo "[INFO] Estado de los contenedores:"
docker-compose ps
