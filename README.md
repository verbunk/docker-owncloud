# ownCloud on Alpine

[![docker hub](https://img.shields.io/badge/docker-image-blue.svg?style=flat-square)](https://registry.hub.docker.com/u/splattael/owncloud/)
[![imagelayers](https://badge.imagelayers.io/splattael/owncloud:latest.svg)](https://imagelayers.io/?images=splattael/owncloud:latest)

## Docker run

    docker run \
      --link mysql:mysql
      --name owncloud \
      -P \
      splattael/owncloud

## Software

* apache2-2.4.12-r1
* php-apache2-5.6.13-r0
* owncloud 8.1.3 (from source)

## Notes

### 8.1.3

* Don't forget to copy `ca-bundle.crt` into your `VOLUME`/config directory
