# Original credit: https://github.com/kylemanna/docker-openvpn

# Smallest base image
FROM alpine:3.4

MAINTAINER Charles Brown <charlieb00@gmail.com>

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk add --update openvpn iptables bash easy-rsa autoconf automake libtool && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    apk add --update alpine-sdk python && \
    curl -L https://github.com/duosecurity/duo_openvpn/tarball/master > /tmp/duo-openvpn.tgz && \
    cd /tmp && tar xvzf duo-openvpn.tgz && cd duosecurity-duo_openvpn* && make install && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Needed by scripts
ENV OPENVPN /etc/openvpn

VOLUME ["/etc/openvpn"]

# Internally uses port 1194/tcp, remap using `docker run -p 443:1194/udp`
EXPOSE 1194/tcp

CMD ["run_openvpn"]

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*
