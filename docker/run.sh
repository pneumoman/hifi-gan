

docker container run -itu ${UID}:${UID} --rm --gpus all -v /media/pneumoman/data:/data \
  -v /home/pneumoman/projects/hifi-gan:/hifi-gan \
  --shm-size 1G \
  hifigan bash