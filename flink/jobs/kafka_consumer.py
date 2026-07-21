from pyflink.datastream import StreamExecutionEnvironment, CheckpointingMode
from pyflink.datastream.connectors.kafka import KafkaSource, KafkaOffsetsInitializer
from pyflink.common.serialization import SimpleStringSchema
from pyflink.common import WatermarkStrategy

env = StreamExecutionEnvironment.get_execution_environment()
env.set_parallelism(2)

# Disable checkpointing by not enabling it
# (checkpointing is disabled by default, just don't call enable_checkpointing)

# Add Kafka connector jar
env.add_jars("file:///opt/flink/opt/flink-sql-connector-kafka-3.2.0-1.19.jar")

source = KafkaSource.builder() \
    .set_bootstrap_servers("kafka:29092") \
    .set_topics("events") \
    .set_group_id("flink-consumer") \
    .set_starting_offsets(KafkaOffsetsInitializer.earliest()) \
    .set_value_only_deserializer(SimpleStringSchema()) \
    .build()

stream = env.from_source(
    source,
    WatermarkStrategy.no_watermarks(),
    "Kafka Source"
)

stream.print()

env.execute("Kafka Consumer Job")
