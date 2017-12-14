FROM ubuntu:16.04

RUN locale-gen ko_KR.UTF-8

ENV LANG ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8

RUN sed -ri 's/\/archive\.ubuntu\.com/\/kr\.archive\.ubuntu\.com/g' /etc/apt/sources.list

RUN \
    apt-get update && \
    apt-get -y install \
        curl sudo \
        git-core build-essential \
        libz3-dev libncurses5-dev \
        unzip bc wget vim \
        && \
    rm -rf /var/lib/apt/lists/*

ADD http://releases.linaro.org/components/toolchain/binaries/5.3-2016.02/aarch64-linux-gnu/gcc-linaro-5.3-2016.02-x86_64_aarch64-linux-gnu.tar.xz /opt/toolchain/

RUN cd /opt/toolchain && tar xf gcc-linaro-5.3-2016.02-x86_64_aarch64-linux-gnu.tar.xz

ADD http://releases.linaro.org/components/toolchain/binaries/5.3-2016.02/arm-linux-gnueabihf/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf.tar.xz /opt/toolchain/

RUN cd /opt/toolchain && tar xf gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf.tar.xz


CMD ["/bin/bash"]

ENV WORK_TOP_PATH /work

ENV PATH $PATH:/opt/toolchain/gcc-linaro-5.3-2016.02-x86_64_arm-linux-gnueabihf/bin:/opt/toolchain/gcc-linaro-5.3-2016.02-x86_64_aarch64-linux-gnu/bin

WORKDIR /work

