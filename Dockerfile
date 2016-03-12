FROM alpine:edge
MAINTAINER James Verbunk <verbunk@gmail.com>

RUN apk --update add \
  nginx php-fpm php-pdo php-json php-openssl \
  php-mysql php-pdo_mysql php-mcrypt \
  php-ctype php-zlib supervisor \
  ca-certificates php-xml php-phar php-mysqli \
  php-zip php-gd php-iconv php-curl php-opcache \ 
  php-ctype php-apcu php-intl php-bcmath php-dom \
  php-xmlreader nano

RUN rm -rf /var/cache/apk/*
ENV TIMEZONE EST

RUN sed -i.bak 's/nginx:x:100:101:nginx/nginx:x:502:20:nginx/g' /etc/passwd

# Fetch ownCloud dist files 
ADD https://github.com/owncloud/core/archive/v9.0.0.tar.gz /tmp/owncloud.tar.gz
ADD https://github.com/owncloud/3rdparty/archive/v9.0.0.tar.gz /tmp/3rdparty.tar.gz
#ADD https://github.com/owncloud/core/archive/v8.2.2.tar.gz /tmp/owncloud.tar.gz
#ADD https://github.com/owncloud/3rdparty/archive/v8.2.2.tar.gz /tmp/3rdparty.tar.gz

# Set ownCloud perms
RUN mkdir -p /owncloud/data
RUN mkdir -p /owncloud/conf
RUN mkdir -p /owncloud/log
RUN mkdir -p /owncloud/run
 
# Install ownCloud 
RUN tar -C /tmp -xzf /tmp/owncloud.tar.gz
RUN tar -C /tmp -xzf /tmp/3rdparty.tar.gz
RUN mv /tmp/core-9.0.0 /owncloud/www/ 
RUN rm -rf /owncloud/www/3rdparty
RUN mv /tmp/3rdparty-9.0.0 /owncloud/www/3rdparty
RUN rm -rf /tmp/owncloud.tar.gz /tmp/3rdparty.tar.gz

ADD /share/dockers/owncloud/conf/owncloud.config.php /owncloud/www/config/config.php

# Fix perms from tar.gz
RUN chown -R nginx /owncloud/www/config
RUN chown -R nginx /owncloud/www/apps
RUN chown -R nginx /owncloud/www/themes
RUN chown nginx /owncloud/data
RUN chown nginx /owncloud/log

ADD owncloud.cron /owncloud/conf/owncloud.cron

RUN rm /etc/nginx/nginx.conf /etc/php/php-fpm.conf
ADD /share/dockers/owncloud/conf/nginx.conf /etc/nginx/nginx.conf
ADD /share/dockers/owncloud/conf/php-fpm.conf /etc/php/php-fpm.conf

ADD /share/dockers/owncloud/conf/owncloud.nginx /owncloud/conf/owncloud.nginx
ADD /share/dockers/owncloud/conf/owncloud.crt /owncloud/conf/owncloud.crt
ADD /share/dockers/owncloud/conf/owncloud.key /owncloud/conf/owncloud.key

ADD /share/dockers/owncloud/conf/owncloud.cron /owncloud/conf/owncloud.cron
RUN crontab /owncloud/conf/owncloud.cron

RUN mkdir -p /var/log/supervisor
ADD /share/dockers/owncloud/conf/super-nginx.conf /owncloud/conf/super-nginx.super
ADD /share/dockers/owncloud/conf/super-fpm.conf /owncloud/conf/super-fpm.super
ADD /share/dockers/owncloud/conf/supervisord.conf /etc/supervisord.conf

VOLUME ["/owncloud/data"]

EXPOSE 7080 7070 9000

CMD ["/usr/bin/supervisord"]
