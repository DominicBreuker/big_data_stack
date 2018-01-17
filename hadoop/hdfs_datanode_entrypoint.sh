#!/bin/bash

set -e

sudo service ssh start

echo "Starting hadoop daemon on datanode"
hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode

echo "Running infinite loop to keep container alive"
while true; do sleep 10000; done
