#!/bin/bash

set -e

sudo service ssh start

for i in `seq 1 10`; do
    echo "Waiting for HDFS to come up... ($i)"
    sleep $i;

    if hdfs dfs -ls /; then
        echo "HDFS available"
        echo "Starting map reduce history server"
        mapred --config $HADOOP_CONF_DIR historyserver
    fi
done

echo "HDFS did not come up! Exiting..."
exit 1

