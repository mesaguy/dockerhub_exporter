default: build

DOCKER_BUILDX_ARGS ?=
DOCKER_IMAGE ?= mesaguy/dockerhub_exporter
ALPINE_VERSION ?= 3.11
GOLANG_VERSION ?= 1.13
DOCKERHUB_EXPORTER_VERSION ?= v0.2.0
# 20200209 There are currently problems compiling on s390x and ppc64le via QEMU
#DOCKER_PLATFORMS = linux/amd64,linux/arm64,linux/arm/v7,linux/ppc64le,linux/s390x,linux/386
DOCKER_PLATFORMS = linux/amd64,linux/arm64,linux/arm/v7,linux/386
DOCKER_TARGET_REGISTRY ?=
BUILD_DATE = `date --utc +%Y%m%d`

build:
	docker buildx create --use && \
	docker buildx build --pull --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg SOURCE_COMMIT=`git rev-parse --short HEAD` \
		--tag ${DOCKER_TARGET_REGISTRY}${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_TARGET_REGISTRY}${DOCKER_IMAGE}:${DOCKERHUB_EXPORTER_VERSION} \
		--tag ${DOCKER_TARGET_REGISTRY}${DOCKER_IMAGE}:${BUILD_DATE} \
		${DOCKER_BUILDX_ARGS} .

push:
	docker buildx create --use && \
	docker buildx build --pull --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg SOURCE_COMMIT=`git rev-parse --short HEAD` \
		--tag ${DOCKER_TARGET_REGISTRY}${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_TARGET_REGISTRY}${DOCKER_IMAGE}:${DOCKERHUB_EXPORTER_VERSION} \
		--tag ${DOCKER_TARGET_REGISTRY}${DOCKER_IMAGE}:${BUILD_DATE} \
		--push \
		${DOCKER_BUILDX_ARGS} .
