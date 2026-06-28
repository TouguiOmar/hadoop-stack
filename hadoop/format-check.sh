#!/bin/bash
set -e

NAMENODE_DIR="/tmp/hadoop-root/dfs/name"

if [ ! -d "$NAMENODE_DIR/current" ]; then
  echo ">>> First time: formatting HDFS namenode..."
  hdfs namenode -format -force -nonInteractive
else
  echo ">>> Namenode already formatted, skipping."
fi

exec hdfs namenode
