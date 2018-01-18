#!/bin/bash

set -e

sudo service ssh start

echo "Starting yarn daemon on resourcemanager"
yarn --config $HADOOP_CONF_DIR resourcemanager
