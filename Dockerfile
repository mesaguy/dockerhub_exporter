ARG ALPINE_VERSION=3.12
ARG DOCKERHUB_EXPORTER_VERSION=v0.2.0
ARG GOLANG_VERSION=1.14

from golang:$GOLANG_VERSION as BUILD

RUN apt-get update && apt-get -y install --no-install-recommends build-essential

# Make and install promu utility
WORKDIR /go/src
RUN git clone https://github.com/prometheus/promu
WORKDIR /go/src/promu
RUN make build && cp -p promu /usr/bin

# Build dockerhub_exporter
RUN mkdir -p github.com/webhippie
WORKDIR /go/src/github.com/webhippie
RUN git clone https://github.com/promhippie/dockerhub_exporter.git
WORKDIR /go/src/github.com/webhippie/dockerhub_exporter
RUN git checkout $DOCKERHUB_EXPORTER_VERSION && \
    make test build

FROM alpine:$ALPINE_VERSION

# Run unprivileged
USER nobody

# Service runs on 9505/tcp
EXPOSE 9505

# Copy dockerhub_exporter binary from build image
COPY --from=BUILD /go/src/github.com/webhippie/dockerhub_exporter/dockerhub_exporter .

ENTRYPOINT ["/dockerhub_exporter"]
CMD ["-dockerhub.org", "debian"]
