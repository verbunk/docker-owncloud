FROM alpine
MAINTAINER Peter Suschlik <peter@suschlik.de>

ENV RELEASE_DATE 2015-06-09

RUN apk add -U apache2 php-apache2
# TODO download owncloud from source

#RUN rm -fr /var/cache/apk/*
#RUN rm -fr /usr/bin/php

EXPOSE 80

CMD /usr/sbin/apachectl -D FOREGROUND
