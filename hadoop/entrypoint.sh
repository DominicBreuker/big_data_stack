#!/bin/bash

echo "$0 | $1"

set -e 

echo ""
echo ""start SSH daemon""
#sudo service ssh start

echo ""
echo "format namenode and bootstrap HDFS"
#hdfs namenode -format
#start-dfs.sh

echo ""
echo "start yarn"
#start-yarn.sh

echo ""
echo "#########################################"
echo "####### Done starting hadoop ############"
echo "#########################################"
echo ""

# if [[ $1 == "-bash"  ]]; then
#     echo "Running bash to work with hadoop"
#     /bin/bash
# else
#     echo "Running infinite loop to keep container alive"
#     while true; do sleep 1000; done
# fi
