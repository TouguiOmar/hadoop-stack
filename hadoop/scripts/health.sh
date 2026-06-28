#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."

echo "=== Hadoop Health Check ==="
echo ""
echo "--- Containers ---"
docker compose ps
echo ""
echo "--- HDFS Report ---"
docker exec hadoop-namenode hdfs dfsadmin -report
echo ""
echo "--- YARN Nodes ---"
docker exec hadoop-resourcemanager yarn node -list
