#!/bin/bash

ngpu=$(nvidia-smi -L | wc -l)

cd /hifi-gan && \
    python train.py --input_wavs_dir "" \
        --input_training_file /data/SLR83_22050/training_list.txt \
        --input_validation_file /data/SLR83_22050/validation_list.txt \
        --checkpoint_path /data/SLR83_22050/training \
        --config config_v3.json
