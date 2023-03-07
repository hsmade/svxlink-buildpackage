FROM ubuntu:jammy
MAINTAINER Wim Fournier <wim@fournier.nl>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        git cmake g++ make libsigc++-2.0-dev libgsm1-dev \
        libpopt-dev tcl8.6-dev libgcrypt20-dev libspeex-dev \
        libasound2-dev alsa-utils vorbis-tools libcurl4-openssl-dev \
        libopus-dev librtlsdr-dev groff doxygen checkinstall libjsoncpp25 libjsoncpp-dev && \
    rm -rf /var/lib/apt/lists/*

COPY build.sh /
CMD ["/build.sh"]
VOLUME /package
