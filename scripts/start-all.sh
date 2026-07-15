#!/bin/bash
echo "► Starting Hadoop (HDFS + YARN)..."
(cd "$(dirname "$0")/../hadoop" && docker compose up -d)

echo "► Starting Hive (Metastore + HiveServer2)..."
(cd "$(dirname "$0")/../hive" && docker compose up -d)

echo "► Starting Spark (Master + Workers)..."
(cd "$(dirname "$0")/../spark" && docker compose up -d)

echo "► Starting Kafka (Zookeeper + Broker + UI)..."
(cd "$(dirname "$0")/../kafka" && docker compose up -d)

echo ""
echo "✅ Stack started"
echo "   HDFS UI  → http://localhost:9870"
echo "   YARN UI  → http://localhost:8088"
echo "   Hive UI  → http://localhost:10002"
echo "   Spark UI → http://localhost:8082"
echo "   Kafka UI → http://localhost:8085"
