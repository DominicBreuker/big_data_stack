#!/bin/bash

set -e

sudo service ssh start

hdfs namenode -format -force

# start-dfs.sh

echo "Starting hadoop daemon on namenode"
hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode

echo "Creating HDFS folders for mapreduce history server"
hdfs dfs -mkdir /mr-history
hdfs dfs -chown mapred:mapred /mr-history

echo "Running infinite loop to keep container alive"
while true; do sleep 10000; done
