#!/bin/bash

CONTAINER_NAME=magic-nginx
CONTAINER_PORT_80=8080
HOST_PORT_80=80
CONTAINER_PORT_443=4343
HOST_PORT_443=443

OUT_DIR=./out
DATA_DIR=/home/j/dev/grundstein/legung/bin/../../data

VERSION=1.10.1
TARGET_DIR=/home/nginx

IP=172.18.0.5

echo "container: $CONTAINER_NAME"

function build {
  docker build \
    --tag=$CONTAINER_NAME \
    . # dot!
}

function run() {
  docker rm -f $CONTAINER_NAME

  docker run \
    --name $CONTAINER_NAME \
    --publish $HOST_PORT_80:$CONTAINER_PORT_80 \
    --publish $HOST_PORT_443:$CONTAINER_PORT_443 \
    --volume $DATA_DIR/nginx/logs:$TARGET_DIR/logs \
    --net user-defined \
    --ip $IP \
    $CONTAINER_NAME
}


if [ $1 ]
then
  function=$1
  shift
  $function $@
else
  help $@
fi
