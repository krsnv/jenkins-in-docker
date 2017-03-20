#!/bin/bash

# Script stops, backup and re-run Jenkins

## Jenkins Docker params
source jenkins.conf

BACKUP_DIR="/storage/backups/jenkins"

## Stops Jenkins container
function stop_jenkins()
{
    docker kill ${CONTAINER_NAME}
    docker rm ${CONTAINER_NAME}
}


## Runs Jenkins container
function run_jenkins()
{
docker run -d --name ${CONTAINER_NAME} \
           -p ${JENKINS_WEB_PORT}:8080 \
           -p ${JENKINS_SER_PORT}:50000 \
           -v ${JENKINS_DATA_DIR}:/var/jenkins_home \
           jenkins
}


## Creates tar.gz archive

function make_backup()
{
    tar czf ${BACKUP_DIR}/jenkins_$(date +%s).tar.gz ${JENKINS_DATA_DIR}
}

stop_jenkins && make_backup && run_jenkins
