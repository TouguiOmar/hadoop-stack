# hadoop-stack

Production-ready Hadoop ecosystem stack using official Docker images.

## Components
- HDFS (NameNode + DataNode)
- YARN (ResourceManager + NodeManager)

## Requirements
- Docker Engine 24+
- Docker Compose v2+
- 8GB RAM minimum

## Quick Start
```bash
git clone https://github.com/otougui/hadoop-stack
cd hadoop-stack
docker compose up -d
```

## Access
| UI | URL |
|---|---|
| HDFS NameNode | http://localhost:9870 |
| YARN ResourceManager | http://localhost:8088 |

## Author
otougui
