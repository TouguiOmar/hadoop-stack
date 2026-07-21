#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."
echo "Starting Flink (JobManager + TaskManager)..."
docker compose up -d
sleep 15
docker compose ps
echo ""
echo "✅ Flink running"
echo "   Flink UI → http://localhost:8081"
