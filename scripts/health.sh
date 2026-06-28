#!/bin/bash
echo "=== Hadoop Stack Health Check ==="
echo ""
echo "--- Containers ---"
docker compose ps
echo ""
echo "--- HDFS Report ---"
docker exec hadoop-namenode hdfs dfsadmin -report
echo ""
echo "--- YARN Nodes ---"
docker exec hadoop-resourcemanager yarn node -list
