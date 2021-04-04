FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y && apt upgrade -y && apt install -y python3-wheel python3-pip sshpass iptables && \
    pip3 install --upgrade wheel pip && \
    apt clean -y && apt autoclean -y

COPY requirements.txt /
COPY requirements.yaml /

RUN pip3 install -r /requirements.txt && ansible-galaxy collection install -r requirements.yaml && pip3 install sshuttle
