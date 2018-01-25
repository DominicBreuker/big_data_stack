#!/bin/bash

hdfs dfs -mkdir -p /data/wiki
hdfs dfs -copyFromLocal /home/hdfs/examples/data/en_articles_part  /data/wiki/en_articles_part
