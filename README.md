# Alpine based Prometheus dockerhub_exporter

[![DockerHub Badge](https://dockeri.co/image/mesaguy/dockerhub_exporter)](https://hub.docker.com/r/mesaguy/dockerhub_exporter)

## Introduction

Simple unprivileged implementation of [promhippie/dockerhub_exporter](https://github.com/promhippie/dockerhub_exporter) built for numerous architectures.

Runs on 9505/tcp as the user 'nobody', daemon logs are send to stdout, and the default command must be overridden. The default command will monitor debian's Docker Hub content.

## Usage

The most basic usage is the following, which monitors 'debian' content:

    docker run --rm -p 9505:9505 -it mesaguy/dockerhub_exporter

To monitor a organization (ie: fedora) use:

    docker run --rm -p 9505:9505 -it mesaguy/dockerhub_exporter /dockerhub_exporter -dockerhub.org fedora

To monitor a repository use:

    docker run --rm -p 9505:9505 -it mesaguy/dockerhub_exporter /dockerhub_exporter -dockerhub.repo mysql/mysql-server,mysql/mysql-cluster

To monitor a organizations and repositories use:

    docker run --rm -p 9505:9505 -it mesaguy/dockerhub_exporter /dockerhub_exporter -dockerhub.repo mysql/mysql-server,mysql/mysql-cluster -dockerhub.org fedora
