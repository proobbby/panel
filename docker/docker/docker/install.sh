#!/bin/bash

set -e

echo "🚀 Building Docker containers..."

docker-compose -f docker-compose.yml build

echo "📦 Starting containers..."

docker-compose -f docker-compose.yml up -d

echo "⌛ Waiting for MySQL to initialize..."
sleep 20

echo "🔑 Generating app key inside container..."
docker exec -it draco_panel_app php artisan key:generate

echo "🧬 Running migrations..."
docker exec -it draco_panel_app php artisan migrate --force

echo "✅ All done! Panel is running at http://localhost:8080"
