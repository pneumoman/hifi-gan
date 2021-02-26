FROM nvcr.io/nvidia/pytorch:20.12-py3

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -yy 

# RUN apt search restricted-extras | grep ext

RUN apt-get install -y libavcodec-extra58 python3-soundfile libsndfile1 python3-pip ubuntu-restricted-extras/focal && \
    apt-get install -y libavcodec-extra ffmpeg


RUN python -m pip install pip --upgrade

# torch==1.4.0
# RUN python -m pip install numpy==1.17.4
RUN conda install numpy
# RUN python -m pip install librosa==0.7.2
RUN conda install -c conda-forge librosa
# RUN python -m pip install scipy==1.4.1
RUN conda install scipy
# RUN python -m pip install tensorboard==2.0
RUN python -m pip install soundfile==0.10.3.post1
# RUN python -m pip install matplotlib==3.1.3
RUN conda install matplotlib
RUN conda install -c conda-forge ffmpeg
RUN python -m pip install ipywidgets \
    && jupyter nbextension enable --py widgetsnbextension

ARG UIDX=1000
ARG USERID=appuser
RUN adduser --disabled-password --uid $UIDX --gecos ',,,,,' $USERID && \
    echo "export PATH=${PATH}:"'$PATH' >> /home/${USERID}/.bashrc && \
    echo 'export IP=$(tail -1 /etc/hosts | sed '"'s/\s..*$//')" >> /home/${USERID}/.bashrc && \
    echo -e '#!/bin/bash\n\ncd /\n\njupyter notebook --ip $IP 2>&1 | sed s/hostname/$IP/' > /home/${USERID}/run_jupyter.sh && \
    chmod +x /home/${USERID}/run_jupyter.sh

ARG USERID=appuser
CMD /home/${USERID}/run_jupyter.sh
