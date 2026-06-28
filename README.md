# hadoop-stack

Production-ready Hadoop ecosystem stack using official Apache Docker images.

## Stack

| Component | Version | Role |
|---|---|---|
| HDFS NameNode | Hadoop 3.3.6 | Manages filesystem metadata |
| HDFS DataNode | Hadoop 3.3.6 | Stores actual data blocks |
| YARN ResourceManager | Hadoop 3.3.6 | Manages cluster resources |
| YARN NodeManager | Hadoop 3.3.6 | Runs application containers |

## Roadmap

| Component | Version | Status |
|---|---|---|
| Apache Spark | 3.5.1 | 🔜 Coming next |
| Apache Hive | 4.0.0 | 🔜 Planned |
| Apache Kafka | 7.6.0 | 🔜 Planned |
| Apache Flink | 1.19 | 🔜 Planned |
| Apache Airflow | 2.9.1 | 🔜 Planned |
| Grafana | 10.4.0 | 🔜 Planned |

## Requirements
- Docker Engine 24+
- Docker Compose v2+
- 8 GB RAM minimum (24 GB recommended for full stack)

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

# List root directory
docker exec hadoop-namenode hdfs dfs -ls /


## Configuration
Edit `.env` to customize memory limits, replication factor, and cluster name.

## Author
[@TouguiOmar](https://github.com/TouguiOmar)
