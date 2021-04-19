FROM alpine:3.13 

RUN apk add --no-cache \
        python3 \
        py3-pip \
        openssl \
        ca-certificates \
        sshpass \
        openssh-client && \
    apk add --no-cache --virtual build-dependencies \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base

ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1

COPY requirements.yaml /
COPY requirements.txt /

RUN pip3 install --upgrade pip && \
    pip3 install wheel && \
    pip3 install -r /requirements.txt

RUN ansible-galaxy collection install -r requirements.yaml

RUN apk del build-dependencies && \
    rm -rf /var/cache/apk/*

WORKDIR /ansible
