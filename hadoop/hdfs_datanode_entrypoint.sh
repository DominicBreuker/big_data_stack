#!/bin/bash

set -e

sudo service ssh start

echo "Starting hadoop daemon on datanode"
hdfs --config $HADOOP_CONF_DIR datanode
