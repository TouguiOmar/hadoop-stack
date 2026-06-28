#!/bin/bash
# ═══════════════════════════════════════════
#  Start all components of the stack
# ═══════════════════════════════════════════

echo "► Starting Hadoop (HDFS + YARN)..."
cd "$(dirname "$0")/../hadoop" && docker compose up -d && cd -

# Future components (uncomment as they are added):
# echo "► Starting Hive..."
# cd "$(dirname "$0")/../hive" && docker compose up -d && cd -

# echo "► Starting Spark..."
# cd "$(dirname "$0")/../spark" && docker compose up -d && cd -

# echo "► Starting Kafka..."
# cd "$(dirname "$0")/../kafka" && docker compose up -d && cd -

echo ""
echo "✅ Stack started"
