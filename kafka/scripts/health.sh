#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."
echo "=== Kafka Health Check ==="
echo ""
echo "--- Containers ---"
docker compose ps
echo ""
echo "--- Topics ---"
docker exec kafka-broker kafka-topics --bootstrap-server localhost:9092 --list 2>/dev/null
echo ""
echo "--- Broker info ---"
docker exec kafka-broker kafka-broker-api-versions --bootstrap-server localhost:9092 2>/dev/null | head -3
