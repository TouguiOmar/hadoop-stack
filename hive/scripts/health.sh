#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."
echo "=== Hive Health Check ==="
echo ""
echo "--- Containers ---"
docker compose ps
echo ""
echo "--- Metastore logs (last 5 lines) ---"
docker logs hive-metastore 2>&1 | tail -5
echo ""
echo "--- HiveServer2 logs (last 5 lines) ---"
docker logs hive-hiveserver2 2>&1 | tail -5
