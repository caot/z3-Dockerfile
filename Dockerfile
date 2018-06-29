# ref https://hub.docker.com/r/fnndsc/ubuntu-python3/~/dockerfile/
# https://github.com/gliderlabs/docker-alpine/issues/38

FROM ubuntu:latest

RUN apt-get update \
 && apt-get install -y \
    python3-pip \
    python3-dev \
    git \
    vim \
    gedit \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip \
  && apt-get clean \
  && mkdir -p /pkgs \
  && cd /pkgs \
  && git clone https://github.com/fdiskyou/z3.git z3.git \
  && cd z3.git \
  && python scripts/mk_make.py --python \
  && cd build && make && make install \
  && rm -rf /pkgs \
  && adduser --disabled-password z3
  
USER z3
WORKDIR /home/z3

ENTRYPOINT ["z3"]
