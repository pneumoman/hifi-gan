#!/bin/bash

export is_there=$(docker container ls -a | grep -c hifigan)

echo $is_there

if [ $is_there -gt 0 ]
then
  docker container stop hifigan
  docker container rm hifigan
fi

docker container run --name hifigan -itdu ${UID}:${UID} --gpus all -v /media/pneumoman/data:/data \
  -v /home/pneumoman/projects/hifi-gan:/hifi-gan \
  --shm-size 1G \
  hifigan bash /hifi-gan/do_training.sh