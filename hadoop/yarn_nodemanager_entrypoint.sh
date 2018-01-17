#!/bin/bash

set -e

sudo service ssh start

echo "Starting yarn daemon on resourcemanager"
yarn-daemon.sh --config $HADOOP_CONF_DIR start nodemanager

echo "Running infinite loop to keep container alive"
while true; do sleep 10000; done
