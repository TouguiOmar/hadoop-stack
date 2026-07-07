#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."
echo "=== Spark Health Check ==="
echo ""
echo "--- Containers ---"
docker compose ps
echo ""
echo "--- Workers registered ---"
docker exec spark-master curl -s http://localhost:8080/json/ | python3 -m json.tool 2>/dev/null | grep -E "workers|status|cores" | head -10
