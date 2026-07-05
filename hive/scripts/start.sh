#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."
echo "Starting Hive (Metastore + HiveServer2 + PostgreSQL)..."
docker compose up -d
echo "Waiting 30s for services to initialize..."
sleep 30
docker compose ps
echo ""
echo "✅ Hive running"
echo "   HiveServer2 UI → http://localhost:10002"
echo "   Beeline → docker exec -it hive-hiveserver2 beeline -u jdbc:hive2://localhost:10000"
