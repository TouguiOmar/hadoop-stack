FROM flink:1.19-scala_2.12

USER root

# Add Kafka connector
COPY lib/flink-sql-connector-kafka-3.2.0-1.19.jar /opt/flink/opt/

# Add Hadoop jars for HDFS support
RUN wget -q https://repo1.maven.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar \
    -O /opt/flink/lib/flink-shaded-hadoop-2-uber.jar

# Add Python support
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    pip3 install apache-flink==1.19.0 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER flink
