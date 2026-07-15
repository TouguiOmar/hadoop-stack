#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."
echo "Starting Kafka (Zookeeper + Broker + UI)..."
docker compose up -d
sleep 20
docker compose ps
echo ""
echo "✅ Kafka running"
echo "   Kafka UI → http://localhost:8085"
echo "   Broker   → localhost:9092"
