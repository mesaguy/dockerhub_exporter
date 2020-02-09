default: build

BUILD_ARGS ?=
DOCKER_IMAGE ?= mesaguy/dockerhub_exporter
ALPINE_VERSION ?= 3.11
DEBIAN_VERSION ?= buster
GOLANG_VERSION ?= 1.13
DOCKERHUB_EXPORTER_VERSION ?= v0.2.0
DOCKER_PLATFORMS = linux/amd64,linux/arm64,linux/arm/v7,linux/ppc64le,linux/s390x,linux/386
BUILD_DATE = `date --utc +%Y%m%d`

build:
	docker buildx create --use && \
	docker buildx build --pull --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg SOURCE_COMMIT=`git rev-parse --short HEAD` \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:${DOCKERHUB_EXPORTER_VERSION} \
		--tag ${DOCKER_IMAGE}:${BUILD_DATE} \
		${DOCKER_BUILDX_ARGS} .

push:
	docker buildx create --use && \
	docker buildx build --pull --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg SOURCE_COMMIT=`git rev-parse --short HEAD` \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:${DOCKERHUB_EXPORTER_VERSION} \
		--tag ${DOCKER_IMAGE}:${BUILD_DATE} \
		--push \
		${DOCKER_BUILDX_ARGS} .
