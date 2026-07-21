#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."
echo "=== Flink Health Check ==="
echo ""
echo "--- Containers ---"
docker compose ps
echo ""
echo "--- Cluster overview ---"
docker exec flink-jobmanager curl -s http://localhost:8081/overview 2>/dev/null | python3 -m json.tool 2>/dev/null | grep -E "taskmanagers|slots|jobs"
