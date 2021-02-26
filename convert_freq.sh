#!/bin/bash

if [ $# -eq 4 ]
then
    root_dir=$1
    out_hz=$2
    repl=$3
    repl_w=$4

    files=$(find $root_dir -name '*.wav')
    for f in $files
    do
        base=${f%\/*}
        base_out=${base/$repl/$repl_w}
        # echo $base_out
        mkdir -p "$base_out"
        f_out=${f/$repl/$repl_w}
        echo "$f_out"
        ffmpeg -v 8 -y -filter_threads 4 -i "$f" -af aresample=${out_hz} -ar ${out_hz} "$f_out"
    done
else
    echo "$0 <dataset_root> <output_hz> <replace_part> <replace with>"
fi