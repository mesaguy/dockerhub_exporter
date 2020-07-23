default: build

DOCKER_BUILDX_ARGS ?=
DOCKER_IMAGE ?= mesaguy/dockerhub_exporter
ALPINE_VERSION ?= 3.12
GOLANG_VERSION ?= 1.14
DOCKERHUB_EXPORTER_VERSION ?= v0.2.0
DOCKER_PLATFORMS = linux/amd64,linux/arm64,linux/arm/v7,linux/ppc64le,linux/386
BUILD_DATE = `date --utc +%Y%m%d`

build:
	docker build --pull \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:${DOCKERHUB_EXPORTER_VERSION} \
		--tag ${DOCKER_IMAGE}:${BUILD_DATE} \
		.

push:
	docker push \
		${DOCKER_IMAGE}:${BUILD_DATE}
	docker push \
		${DOCKER_IMAGE}:${DOCKERHUB_EXPORTER_VERSION}
	docker push \
		${DOCKER_IMAGE}:latest

build_multiarch:
	docker buildx create --use && \
	docker buildx build --pull --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:${DOCKERHUB_EXPORTER_VERSION} \
		--tag ${DOCKER_IMAGE}:${BUILD_DATE} \
		${DOCKER_BUILDX_ARGS} .

push_multiarch:
	docker buildx create --use && \
	docker buildx build --pull --platform ${DOCKER_PLATFORMS} \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--tag ${DOCKER_IMAGE}:latest \
		--tag ${DOCKER_IMAGE}:${DOCKERHUB_EXPORTER_VERSION} \
		--tag ${DOCKER_IMAGE}:${BUILD_DATE} \
		--push \
		${DOCKER_BUILDX_ARGS} .
