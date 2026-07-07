# Tez Integration — TODO

## Status
Tez configuration files are in place but DAGAppMaster fails to launch.

## Root Cause
The `apache/hadoop:3.3.6` NodeManager image does not have Tez installed.
When YARN tries to launch the Tez ApplicationMaster container on the NodeManager,
it cannot find `org.apache.tez.dag.app.DAGAppMaster` even though the tez.tar.gz
is correctly uploaded to HDFS at `hdfs://namenode:9000/tez/tez.tar.gz`.

## What Was Tried
- Uploaded Tez 0.10.3 tarball to HDFS
- Set `tez.lib.uris` in tez-site.xml
- Set `tez.lib.uris.classpath` to `tez/,tez/lib/`
- Set `tez.use.cluster.hadoop-libs=true`
- Set `tez.cluster.additional.classpath.prefix`

## Solution (to implement later)
Build a custom NodeManager Docker image based on `apache/hadoop:3.3.6`
that includes Tez installation:

```dockerfile
FROM apache/hadoop:3.3.6
COPY --from=apache/hive:4.0.0 /opt/tez /opt/tez
ENV TEZ_HOME=/opt/tez
```

Then update `hadoop/docker-compose.yml` to use this custom image
for the nodemanager service.

## Files
- `hive/config/tez-site.xml` — Tez configuration
- `/tez/tez.tar.gz` on HDFS — Tez binaries
- `hive/config/hive-site.xml` — currently set to `mr`, change to `tez` when fixed
