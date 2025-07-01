#!/bin/bash

echo "📦 Cloning Draco Panel source code..."

if [ -d "temp" ]; then
  rm -rf temp
fi

git clone https://github.com/proobbby/panel.git temp || { echo "Failed to clone panel repo"; exit 1; }

echo "📂 Copying source files..."
cp -r temp/* ./
rm -rf temp

echo "⚙️ Building and starting Docker containers..."
docker-compose build || { echo "Docker build failed"; exit 1; }
docker-compose up -d || { echo "Docker up failed"; exit 1; }

echo "✅ Draco Panel is running."
