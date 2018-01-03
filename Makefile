

build:
	docker build -f ./docker/Dockerfile.hadoop.master -t local/hadoop_master .

run:
	docker run -it --rm -P local/hadoop_master /bin/bash
