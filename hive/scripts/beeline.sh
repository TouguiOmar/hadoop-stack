#!/bin/bash
echo "Connecting to HiveServer2 via Beeline..."
docker exec -it hive-hiveserver2 beeline -u "jdbc:hive2://localhost:10000" -n root
