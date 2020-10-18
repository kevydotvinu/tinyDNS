FROM alpine

MAINTAINER Vinu K <vinu@gnulinuxmate.com>

RUN apk add --update bind && \
    rm -rf /var/cache/apk/* && \
    mkdir /var/lib/bind

ENTRYPOINT ["/usr/sbin/named", "-f", "-g"]
