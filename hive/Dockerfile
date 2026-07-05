FROM apache/hive:4.0.0

USER root
RUN apt-get update && apt-get install -y wget && \
    wget -q https://jdbc.postgresql.org/download/postgresql-42.7.3.jar \
    -O /opt/hive/lib/postgresql-42.7.3.jar && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER hive
