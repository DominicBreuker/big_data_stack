#!/bin/bash

set -e

sudo service ssh start

echo "Starting map reduce history server"
mr-jobhistory-daemon.sh --config $HADOOP_CONF_DIR start historyserver

echo "Running infinite loop to keep container alive"
while true; do sleep 10000; done
