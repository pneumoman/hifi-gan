#!/bin/bash
logdir=$1
# IP=$2
export port=9996
echo "port=${port}"

docker run --rm -itd --name tensorboard -v "${logdir}":/logdir -p "$port":"$port" tensorflow/tensorflow tensorboard --host '0.0.0.0' --port "$port" --logdir /logdir
