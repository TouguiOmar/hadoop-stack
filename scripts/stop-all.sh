#!/bin/bash
# ═══════════════════════════════════════════
#  Stop all components of the stack
# ═══════════════════════════════════════════

echo "► Stopping Hadoop..."
cd "$(dirname "$0")/../hadoop" && docker compose down && cd -

# Future components (uncomment as they are added):
# echo "► Stopping Hive..."
# cd "$(dirname "$0")/../hive" && docker compose down && cd -

# echo "► Stopping Spark..."
# cd "$(dirname "$0")/../spark" && docker compose down && cd -

# echo "► Stopping Kafka..."
# cd "$(dirname "$0")/../kafka" && docker compose down && cd -

echo ""
echo "✅ Stack stopped"
