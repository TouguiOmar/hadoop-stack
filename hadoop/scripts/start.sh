#!/bin/bash
echo "Starting Hadoop (HDFS + YARN)..."
docker compose up -d
echo "Waiting 20s for NameNode..."
sleep 20
docker exec hadoop-namenode hdfs dfsadmin -report
echo ""
echo "✅ Hadoop running"
echo "   HDFS UI → http://localhost:9870"
echo "   YARN UI → http://localhost:8088"
