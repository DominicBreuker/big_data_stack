DOCKER_COMPOSE_FILE = docker-compose.yml


BASE_IMAGE = local/hadoop_base

HDFS_NAMENODE_IMAGE = local/hadoop_hdfs_namenode
export HDFS_NAMENODE_IMAGE_NAME = $(HDFS_NAMENODE_IMAGE)
HDFS_DATANODE_IMAGE = local/hadoop_hdfs_datanode
export HDFS_DATANODE_IMAGE_NAME = $(HDFS_DATANODE_IMAGE)

YARN_RESOURCEMANAGER_IMAGE = local/hadoop_yarn_resourcemanager
export YARN_RESOURCEMANAGER_IMAGE_NAME = $(YARN_RESOURCEMANAGER_IMAGE)
YARN_NODEMANAGER_IMAGE = local/hadoop_yarn_nodemanager
export YARN_NODEMANAGER_IMAGE_NAME = $(YARN_NODEMANAGER_IMAGE)

MAPRED_HIST_IMAGE = local/hadoop_mapred_hist
export MAPRED_HIST_IMAGE_NAME = $(MAPRED_HIST_IMAGE)

EDGE_IMAGE = local/hadoop_edge_node
export EDGE_IMAGE_NAME = $(EDGE_IMAGE)

build:
	docker build -f ./hadoop/docker/Dockerfile.hadoop.base -t $(BASE_IMAGE) hadoop
	docker build -f ./hadoop/docker/Dockerfile.hadoop.hdfs.master -t $(HDFS_NAMENODE_IMAGE) hadoop
	docker build -f ./hadoop/docker/Dockerfile.hadoop.hdfs.slave -t $(HDFS_DATANODE_IMAGE) hadoop
	docker build -f ./hadoop/docker/Dockerfile.hadoop.yarn.master -t $(YARN_RESOURCEMANAGER_IMAGE) hadoop
	docker build -f ./hadoop/docker/Dockerfile.hadoop.yarn.slave -t $(YARN_NODEMANAGER_IMAGE) hadoop
	docker build -f ./hadoop/docker/Dockerfile.hadoop.mapredhist -t $(MAPRED_HIST_IMAGE) hadoop
	docker build -f ./examples/docker/Dockerfile.hadoop.edge -t $(EDGE_IMAGE) examples

keygen:
	mkdir -p hadoop/ssh/keys
	rm -f hadoop/ssh/keys/bds*
	ssh-keygen -t rsa -P '' -f hadoop/ssh/keys/bds
	chmod 0600 hadoop/ssh/keys/bds
	@echo "Key generated"

run:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up --scale hdfs-datanode=2 --scale yarn-nodemanager=2

stop:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

bash-mapred-hist:
	docker-compose -f $(DOCKER_COMPOSE_FILE) run mapred-hist /bin/bash

edge:
	docker-compose -f $(DOCKER_COMPOSE_FILE) run edge /bin/bash
