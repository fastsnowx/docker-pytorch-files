FROM nvidia/cuda:11.3.0-runtime-ubuntu20.04
WORKDIR /workspace
ARG DOCKER_UID=1000
ARG DOCKER_USER=dev-user
ARG DOCKER_PASSWORD=docker

# RUN useradd -m -d /home/dev-user -s /bin/bash dev-user
RUN apt-get update
RUN apt-get install -y sudo

RUN useradd -m --uid ${DOCKER_UID} --groups sudo ${DOCKER_USER} -s /usr/bin/bash \
&& echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd


RUN apt-get install -y software-properties-common tzdata
ENV TZ=Asia/Tokyo 
RUN add-apt-repository ppa:deadsnakes/ppa
# pipの他に最低限使いそうなもの
RUN apt-get install -y python3-pip git vim wget zsh
# Ubuntuデフォルトのpython3をpythonに置き換えるようにシンボリックリンクの作成
RUN ln -s /usr/bin/python3.8 /usr/bin/python
# PyTorchのバージョンにあわせて変える

RUN sudo apt-get upgrade -y

USER ${DOCKER_USER}

RUN pip install torch==1.11.0+cu113 torchvision==0.12.0+cu113 torchaudio==0.11.0+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html