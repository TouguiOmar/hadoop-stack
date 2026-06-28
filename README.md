# hadoop-stack

Production-ready Hadoop ecosystem stack using official Apache Docker images.

## Stack
| Component | Role |
|---|---|
| HDFS NameNode | Manages filesystem metadata |
| HDFS DataNode | Stores actual data blocks |
| YARN ResourceManager | Manages cluster resources |
| YARN NodeManager | Runs application containers |

## Requirements
- Docker Engine 24+
- Docker Compose v2+
- 8 GB RAM minimum

## Quick Start
```bash
git clone https://github.com/TouguiOmar/hadoop-stack
cd hadoop-stack
docker compose up -d
```

## Health Check
```bash
bash scripts/health.sh
```

## Access
| UI | URL |
|---|---|
| HDFS NameNode | http://localhost:9870 |
| YARN ResourceManager | http://localhost:8088 |

## Configuration
Edit `.env` to customize memory limits, replication factor, and cluster name.

## Author
[@TouguiOmar](https://github.com/TouguiOmar)
