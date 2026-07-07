from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("SparkSQLHive") \
    .master("spark://spark-master:7077") \
    .config("spark.hadoop.fs.defaultFS", "hdfs://namenode:9000") \
    .config("spark.sql.warehouse.dir", "hdfs://namenode:9000/user/hive/warehouse") \
    .config("hive.metastore.uris", "thrift://hive-metastore:9083") \
    .enableHiveSupport() \
    .getOrCreate()

spark.sparkContext.setLogLevel("WARN")

print("=" * 40)
print("Spark SQL — querying Hive tables")
print("=" * 40)

# Show available databases
print("\nDatabases:")
spark.sql("SHOW DATABASES").show()

# Use learning database
spark.sql("USE default")

# Show tables
print("Tables in default:")
spark.sql("SHOW TABLES").show()

# Query employees table
print("Employees:")
spark.sql("SELECT * FROM employees ORDER BY salary DESC").show()

# Analytics query
print("Department summary:")
spark.sql("""
    SELECT
        department,
        COUNT(*) as headcount,
        AVG(salary) as avg_salary,
        MAX(salary) as max_salary,
        MIN(salary) as min_salary
    FROM employees
    GROUP BY department
    ORDER BY avg_salary DESC
""").show()

# Write results to HDFS as Parquet
print("Writing results to HDFS as Parquet...")
result = spark.sql("""
    SELECT department, COUNT(*) as headcount, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department
""")

result.write \
    .mode("overwrite") \
    .parquet("hdfs://namenode:9000/user/otougui/dept_summary")

print("✅ Written to hdfs://namenode:9000/user/otougui/dept_summary")

# Read back and verify
print("\nReading back from Parquet:")
spark.read.parquet("hdfs://namenode:9000/user/otougui/dept_summary").show()

spark.stop()
print("Done!")
