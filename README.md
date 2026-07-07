# hadoop-stack

Production-ready Hadoop ecosystem stack using official Apache Docker images.
Built for learning the full Hadoop ecosystem step by step.

---

## Current Stack

| Component | Version | Role | Status |
|---|---|---|---|
| HDFS NameNode | Hadoop 3.3.6 | Manages filesystem metadata | ✅ Running |
| HDFS DataNode | Hadoop 3.3.6 | Stores actual data blocks | ✅ Running |
| YARN ResourceManager | Hadoop 3.3.6 | Manages cluster resources | ✅ Running |
| YARN NodeManager | Hadoop 3.3.6 | Runs application containers | ✅ Running |
| Hive Metastore | Hive 4.0.0 | Table metadata — PostgreSQL backend | ✅ Running |
| HiveServer2 | Hive 4.0.0 | SQL queries via Beeline/JDBC | ✅ Running |
| PostgreSQL | 15 | Hive metastore backend | ✅ Running |

---

## Roadmap

| Component | Version | Role | Status |
|---|---|---|---|
| Apache Spark | 3.5.3 | In-memory distributed processing | ✅ Running |
| Apache Kafka | 7.6.0 | Event streaming | 🔜 Planned |
| Apache Flink | 1.19 | Real-time stream processing | 🔜 Planned |
| Apache Airflow | 2.9.1 | Pipeline orchestration | 🔜 Planned |
| Apache Ranger | 2.4.0 | Authorization and audit | 🔜 Planned |
| MIT Kerberos | 1.21 | Authentication | 🔜 Planned |
| Grafana | 10.4.0 | Monitoring dashboards | 🔜 Planned |

---

## Requirements

- Docker Engine 24+
- Docker Compose v2+
- 24 GB RAM recommended (Contabo Cloud VPS 30)

---

## Project Structure
hadoop-stack/
├── hadoop/                        # HDFS + YARN
│   ├── docker-compose.yml
│   ├── format-check.sh
│   └── scripts/
│       ├── start.sh
│       └── health.sh
├── hive/                          # Hive + PostgreSQL metastore
│   ├── docker-compose.yml
│   ├── config/
│   │   ├── hive-site.xml
│   │   ├── core-site.xml
│   │   ├── mapred-site.xml
│   │   └── yarn-site.xml
│   ├── lib/
│   │   └── postgresql-42.7.3.jar
│   └── scripts/
├── scripts/                       # Root orchestration
│   ├── start-all.sh
│   ├── stop-all.sh
│   └── health.sh
└── README.md

---

## Quick Start

```bash
git clone https://github.com/TouguiOmar/hadoop-stack
cd hadoop-stack
bash scripts/start-all.sh
```

---

## Access

All UIs are accessible via SSH tunnel only — no public ports exposed.

| UI | URL | Credentials |
|---|---|---|
| HDFS NameNode | http://localhost:9870 | none |
| YARN ResourceManager | http://localhost:8088 | none |
| HiveServer2 Web UI | http://localhost:10002 | none |

---

## HDFS Commands

```bash
# Create a directory
docker exec hadoop-namenode hdfs dfs -mkdir -p /user/otougui

# List root directory
docker exec hadoop-namenode hdfs dfs -ls /

# Upload a file to HDFS
docker exec hadoop-namenode hdfs dfs -put /local/path /user/otougui/

# Download a file from HDFS
docker exec hadoop-namenode hdfs dfs -get /user/otougui/file /tmp/

# Check HDFS disk usage
docker exec hadoop-namenode hdfs dfs -du -h /

# Remove a directory
docker exec hadoop-namenode hdfs dfs -rm -r /user/otougui
```

---

## Hive — Beeline CLI

```bash
# Connect to HiveServer2
docker exec -it hive-hiveserver2 beeline -u "jdbc:hive2://localhost:10000" -n hive
```

Required session settings before running queries:

```sql
SET mapreduce.framework.name=yarn;
SET yarn.resourcemanager.address=resourcemanager:8032;
SET yarn.app.mapreduce.am.env=HADOOP_MAPRED_HOME=/opt/hadoop;
SET mapreduce.map.env=HADOOP_MAPRED_HOME=/opt/hadoop;
SET mapreduce.reduce.env=HADOOP_MAPRED_HOME=/opt/hadoop;
```

Example queries:

```sql
SHOW DATABASES;
CREATE DATABASE learning;
USE learning;

CREATE TABLE employees (
  id INT,
  name STRING,
  department STRING,
  salary DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

INSERT INTO employees VALUES (1, 'Omar', 'Engineering', 85000);

SELECT department, COUNT(*) as headcount, AVG(salary) as avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;
```

---

## Production Considerations

### Security
- Enable Kerberos authentication for all services
- Use Apache Ranger for fine-grained authorization
- Enable SSL/TLS for inter-node communication
- Set `dfs.permissions=true` in production
- Use HDFS encryption zones for sensitive data

### High Availability
- Run Active + Standby NameNode with ZooKeeper failover
- Run multiple ResourceManagers
- Use minimum 3 DataNodes
- Set `dfs.replication=3`

### Monitoring
- Add Prometheus JMX exporter to each service
- Build Grafana dashboards for HDFS, YARN, Hive metrics
- Alert on dead DataNodes, disk space, under-replicated blocks

### Sizing Guidelines

| Cluster Size | DataNodes | RAM per Node | Replication |
|---|---|---|---|
| Dev (this stack) | 1 | 24 GB | 1 |
| Small | 5–10 | 32–64 GB | 3 |
| Large | 20+ | 128–256 GB | 3 |

---

## Author

[@TouguiOmar](https://github.com/TouguiOmar)
