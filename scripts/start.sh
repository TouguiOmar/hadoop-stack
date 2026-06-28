#!/bin/bash
echo "Starting Hadoop Stack..."
docker compose up -d
echo "Waiting for NameNode to be ready..."
sleep 20
docker exec hadoop-namenode hdfs dfsadmin -report
echo ""
echo "✅ Hadoop Stack is running"
echo "   HDFS UI  → http://localhost:9870"
echo "   YARN UI  → http://localhost:8088"
