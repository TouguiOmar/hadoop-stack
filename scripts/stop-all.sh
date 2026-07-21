#!/bin/bash
echo "► Stopping Flink..."
(cd "$(dirname "$0")/../flink" && docker compose down)

echo "► Stopping Kafka..."
(cd "$(dirname "$0")/../kafka" && docker compose down)

echo "► Stopping Spark..."
(cd "$(dirname "$0")/../spark" && docker compose down)

echo "► Stopping Hive..."
(cd "$(dirname "$0")/../hive" && docker compose down)

echo "► Stopping Hadoop..."
(cd "$(dirname "$0")/../hadoop" && docker compose down)

echo ""
echo "✅ Stack stopped (volumes preserved)"
