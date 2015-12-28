# ownCloud on Alpine 3.2

[![docker hub](https://img.shields.io/badge/docker-image-blue.svg?style=flat-square)](https://registry.hub.docker.com/u/splattael/owncloud/)
[![imagelayers](https://badge.imagelayers.io/splattael/owncloud:latest.svg)](https://imagelayers.io/?images=splattael/owncloud:latest)

## Docker run

    docker run \
      --link mysql:mysql
      --name owncloud \
      -P \
      splattael/owncloud

## Software

* apache2-2.4.16-r0
* php-apache2-5.6.14-r0
* owncloud 8.2.2 (from source)

## Notes

### 8.1.3

* Don't forget to copy `ca-bundle.crt` into your `VOLUME`/config directory
