#!/bin/bash
# ═══════════════════════════════════════════
#  Health check for all stack components
# ═══════════════════════════════════════════

echo "► Hadoop health..."
cd "$(dirname "$0")/../hadoop" && bash scripts/health.sh && cd -

# Future components (uncomment as they are added):
# echo "► Hive health..."
# cd "$(dirname "$0")/../hive" && bash scripts/health.sh && cd -

# echo "► Spark health..."
# cd "$(dirname "$0")/../spark" && bash scripts/health.sh && cd -
