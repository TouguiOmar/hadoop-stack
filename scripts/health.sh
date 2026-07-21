#!/bin/bash
echo "► Hadoop health..."
(cd "$(dirname "$0")/../hadoop" && bash scripts/health.sh)

echo ""
echo "► Hive health..."
(cd "$(dirname "$0")/../hive" && bash scripts/health.sh)

echo ""
echo "► Spark health..."
(cd "$(dirname "$0")/../spark" && bash scripts/health.sh)

echo ""
echo "► Kafka health..."
(cd "$(dirname "$0")/../kafka" && bash scripts/health.sh)

echo ""
echo "► Flink health..."
(cd "$(dirname "$0")/../flink" && bash scripts/health.sh)
