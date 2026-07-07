from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("SparkHDFS") \
    .master("spark://spark-master:7077") \
    .config("spark.hadoop.fs.defaultFS", "hdfs://namenode:9000") \
    .getOrCreate()

spark.sparkContext.setLogLevel("WARN")

print("=" * 40)
print("Reading employees table from HDFS")
print("=" * 40)

# Read directly from HDFS warehouse path
df = spark.read \
    .option("header", "false") \
    .option("delimiter", ",") \
    .schema("id INT, name STRING, department STRING, salary DOUBLE") \
    .csv("hdfs://namenode:9000/user/hive/warehouse/employees/")

df.show()

print("Department averages via Spark:")
df.groupBy("department") \
  .avg("salary") \
  .orderBy("avg(salary)", ascending=False) \
  .show()

print("HDFS files read:")
df.printSchema()

spark.stop()
print("Done!")
