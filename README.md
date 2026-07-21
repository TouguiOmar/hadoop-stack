# hadoop-stack

Production-ready modern data platform using official Apache Docker images.
Built component by component for learning the full Hadoop ecosystem.

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
| Spark Master | Spark 3.5.3 | Manages Spark cluster | ✅ Running |
| Spark Worker x2 | Spark 3.5.3 | Executes Spark jobs | ✅ Running |
| Kafka Broker | Confluent 7.6.0 | Event streaming | ✅ Running |
| Zookeeper | Confluent 7.6.0 | Kafka coordination | ✅ Running |
| Kafka UI | Latest | Kafka web management | ✅ Running |

---

## Roadmap

| Component | Version | Role | Status |
|---|---|---|---|
| Apache Flink | 1.19 | Real-time stream processing | ✅ Running |
| Apache Airflow | 2.9.1 | Pipeline orchestration | 🔜 Planned |
| Apache Ranger | 2.4.0 | Authorization and audit | 🔜 Planned |
| MIT Kerberos | 1.21 | Authentication | 🔜 Planned |
| Grafana | 10.4.0 | Monitoring dashboards | 🔜 Planned |
| Tez | 0.10.3 | Hive execution engine (see TEZ_TODO.md) | 🔧 Pending fix |

---

## Requirements

- Docker Engine 24+
- Docker Compose v2+
- 24 GB RAM (Contabo Cloud VPS 30)

---

---

## Quick Start

```bash
git clone https://github.com/TouguiOmar/hadoop-stack
cd hadoop-stack
bash scripts/start-all.sh
```

---

## Access (via SSH tunnel)

Start tunnel from Windows:
```powershell
ssh contabo-tunnel
```

| UI | URL | Credentials |
|---|---|---|
| HDFS NameNode | http://localhost:9870 | none |
| YARN ResourceManager | http://localhost:8088 | none |
| HiveServer2 Web UI | http://localhost:10002 | none |
| Spark Master UI | http://localhost:8082 | none |
| Kafka UI | http://localhost:8085 | none |

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

Required session settings:
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

## Spark — Submit Jobs

```bash
# Submit a PySpark job
docker exec spark-master /opt/spark/bin/spark-submit \
  --master spark://spark-master:7077 \
  /opt/spark-jobs/your_job.py
```

Available example jobs in `spark/jobs/`:

| Job | Description |
|---|---|
| test_spark.py | Basic DataFrame operations |
| spark_hdfs.py | Read employees data from HDFS |
| spark_sql_hive.py | Spark SQL on Hive metastore + write Parquet |

---

## Kafka — CLI Commands

```bash
# Create a topic
docker exec kafka-broker kafka-topics \
  --bootstrap-server localhost:9092 \
  --create --topic events \
  --partitions 3 --replication-factor 1

# List topics
docker exec kafka-broker kafka-topics \
  --bootstrap-server localhost:9092 --list

# Produce messages
docker exec -it kafka-broker kafka-console-producer \
  --bootstrap-server localhost:9092 --topic events

# Consume messages
docker exec -it kafka-broker kafka-console-consumer \
  --bootstrap-server localhost:9092 --topic events --from-beginning
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
- Use minimum 3 DataNodes and 3 Kafka brokers
- Set `dfs.replication=3`

### Monitoring
- Add Prometheus JMX exporter to each service
- Build Grafana dashboards for HDFS, YARN, Hive, Spark, Kafka metrics
- Alert on dead DataNodes, consumer lag, disk space

### Sizing Guidelines

| Cluster Size | Nodes | RAM per Node | Replication |
|---|---|---|---|
| Dev (this stack) | 1 | 24 GB | 1 |
| Small | 5–10 | 32–64 GB | 3 |
| Large | 20+ | 128–256 GB | 3 |

---

## Author

[@TouguiOmar](https://github.com/TouguiOmar)
