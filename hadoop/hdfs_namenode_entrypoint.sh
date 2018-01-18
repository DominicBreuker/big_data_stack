#!/bin/bash

set -e

sudo service ssh start

hdfs namenode -format -force

echo "Starting hadoop daemon on namenode"
hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode


for i in `seq 1 10`; do
    echo "Waiting for HDFS to come up... ($i)"
    sleep $i;

    if hdfs dfs -ls /; then
        echo "HDFS available"
        echo "Creating HDFS folders for mapreduce history server"

        hdfs dfs -mkdir -p /tmp
        hdfs dfs -chmod -R 1777 /tmp

        echo "Running infinite loop to keep container alive"
        while true; do sleep 10000; done
    fi
done

echo "ERROR: could not create HDFS folders for mapreduce history server"

echo "Running infinite loop to keep container alive"
while true; do sleep 10000; done
