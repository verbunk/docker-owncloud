FROM alpine
MAINTAINER Peter Suschlik <peter@suschlik.de>

ENV RELEASE_DATE 2015-06-09

RUN apk add -U apache2 php-apache2
# TODO download owncloud from source

#RUN rm -fr /var/cache/apk/*
#RUN rm -fr /usr/bin/php

ENV OWNCLOUD_VERSION 8.0.4
ENV OWNCLOUD_URL https://download.owncloud.org/community/owncloud-$OWNCLOUD_VERSION.tar.bz2

RUN apk add -U curl

WORKDIR /tmp
RUN curl -Ls -o owncloud.tar.bz2 $OWNCLOUD_URL
RUN tar xjf owncloud.tar.bz2

ADD owncloud.conf /etc/apache2/conf.d/

RUN apk add --progress -U php-json php-mysql php-curl php-xml php-iconv php-ctype php-dom php-posix php-zip php-zlib php-bz2 php-intl php-openssl php-mcrypt php-ftp php-xcache
RUN apk add -U php-pdo_mysql
RUN apk add -U php-gd

RUN chown -R apache:apache /tmp/owncloud

EXPOSE 80

CMD /usr/sbin/apachectl -D FOREGROUND
