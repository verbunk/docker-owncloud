# ownCloud on Alpine

[![docker hub](https://img.shields.io/badge/docker-image-blue.svg?style=flat-square)](https://registry.hub.docker.com/u/splattael/owncloud/)

Image size: 110.8 MB

## Docker run

    docker run \
      --link mysql:mysql
      --name owncloud \
      -P \
      splattael/owncloud

## Software

* apache2-2.4.10-r0
* php-apache2-5.6.8-r0
* owncloud 8.1.0 (from source)
