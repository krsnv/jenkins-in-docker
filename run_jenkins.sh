#!/bin/bash

# Run Jenkins CI

source jenkins.conf

docker kill ${CONTAINER_NAME}
docker rm ${CONTAINER_NAME}

docker run -d --name ${CONTAINER_NAME} \
           -p ${JENKINS_WEB_PORT}:8080 \
           -p ${JENKINS_SER_PORT}:50000 \
           -v ${JENKINS_DATA_DIR}:/var/jenkins_home \
           jenkins


