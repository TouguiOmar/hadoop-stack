#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."
echo "Starting Spark (Master + 2 Workers)..."
docker compose up -d
sleep 15
docker compose ps
echo ""
echo "✅ Spark running"
echo "   Spark UI → http://localhost:8082"
