BASE_IMAGE = local/hadoop_base
NAMENODE_IMAGE = local/hadoop_hdfs_namenode
DATANODE_IMAGE = local/hadoop_hdfs_datanode

build:
	docker build -f ./docker/Dockerfile.hadoop.base -t $(BASE_IMAGE) .
	docker build -f ./docker/Dockerfile.hadoop.hdfs.namenode -t $(NAMENODE_IMAGE) .
	docker build -f ./docker/Dockerfile.hadoop.hdfs.datanode -t $(DATANODE_IMAGE) .

keygen:
	mkdir -p ssh
	rm ssh/id_rsa
	ssh-keygen -t rsa -P '' -f ssh/id_rsa
	chmod 0600 ssh/id_rsa
	@echo "Key generated"

run:
	docker run -it --rm -p 50070:50070 -p 8088:8088 local/hadoop_master -bash
