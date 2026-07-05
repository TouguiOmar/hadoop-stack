#!/bin/bash
echo "► Stopping Hive..."
(cd "$(dirname "$0")/../hive" && docker compose down)

echo "► Stopping Hadoop..."
(cd "$(dirname "$0")/../hadoop" && docker compose down)

echo ""
echo "✅ Stack stopped (volumes preserved)"
