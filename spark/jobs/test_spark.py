from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("TestSpark") \
    .master("spark://spark-master:7077") \
    .getOrCreate()

spark.sparkContext.setLogLevel("WARN")

print("=" * 40)
print("Spark version:", spark.version)
print("=" * 40)

# Simple test — create a DataFrame
data = [("Omar", "Engineering", 85000),
        ("Sara", "Data", 92000),
        ("Karim", "Engineering", 78000),
        ("Lina", "Marketing", 65000),
        ("Ahmed", "Data", 88000)]

df = spark.createDataFrame(data, ["name", "department", "salary"])
df.show()

print("Department averages:")
df.groupBy("department") \
  .avg("salary") \
  .orderBy("avg(salary)", ascending=False) \
  .show()

spark.stop()
print("Done!")
