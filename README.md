# Alpine based Prometheus dockerhub_exporter

[![DockerHub Badge](http://dockeri.co/image/mesaguy/dockerhub_exporter)](https://hub.docker.com/r/mesaguy/dockerhub_exporter)

## Introduction

Simple unprivileged implementation of [promhippie/dockerhub_exporter](https://github.com/promhippie/dockerhub_exporter) built for numerous architectures.

Runs on 9505/tcp as the user 'nobody', daemon logs are send to stdout, and the default command must be overridden. The default command will monitor mesaguy's Docker Hub content.

## Usage

The most basic usage is the following, which monitors 'mesaguy' content (not very useful):

    docker run -p 9505:9505 -t mesaguy/dockerhub_exporter

To monitor a custom organization (ie: debian) use:

    docker run -p 9505:9505 -t mesaguy/dockerhub_exporter /dockerhub_exporter -dockerhub.org debian

To monitor a custom repository use:

    docker run -p 9505:9505 -t mesaguy/dockerhub_exporter /dockerhub_exporter -dockerhub.repo mysql/mysql-server,mysql/mysql-cluster
