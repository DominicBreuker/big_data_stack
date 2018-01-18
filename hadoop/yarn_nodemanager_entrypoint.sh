#!/bin/bash

set -e

sudo service ssh start

echo "Starting yarn daemon on nodemanager"
yarn --config $HADOOP_CONF_DIR nodemanager
