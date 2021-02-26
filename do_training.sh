#!/bin/bash

ngpu=$(nvidia-smi -L | wc -l)

cd /hifi-gan && \
    python train.py --input_wavs_dir "" \
        --input_training_file /data/SLR83_44k/training_list.txt \
        --input_validation_file /data/SLR83_44k/validation_list.txt \
        --checkpoint_path /data/SLR83_44k/training \
        --config config_v3_44k.json
