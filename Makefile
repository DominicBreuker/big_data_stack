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

build:
	docker build -f ./docker/Dockerfile.hadoop.base -t $(BASE_IMAGE) .
	docker build -f ./docker/Dockerfile.hadoop.hdfs.master -t $(HDFS_NAMENODE_IMAGE) .
	docker build -f ./docker/Dockerfile.hadoop.hdfs.slave -t $(HDFS_DATANODE_IMAGE) .
	docker build -f ./docker/Dockerfile.hadoop.yarn.master -t $(YARN_RESOURCEMANAGER_IMAGE) .
	docker build -f ./docker/Dockerfile.hadoop.yarn.slave -t $(YARN_NODEMANAGER_IMAGE) .
	docker build -f ./docker/Dockerfile.hadoop.mapredhist -t $(MAPRED_HIST_IMAGE) .

keygen:
	mkdir -p ssh/keys
	rm -f ssh/keys/bds*
	ssh-keygen -t rsa -P '' -f ssh/keys/bds
	chmod 0600 ssh/keys/bds
	@echo "Key generated"

run:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up --scale hdfs-datanode=2 --scale yarn-nodemanager=2

