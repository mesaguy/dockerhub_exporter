ARG ALPINE_VERSION=latest
ARG DEBIAN_VERSION=buster
ARG GOLANG_VERSION=1.13
ARG SOURCE_COMMIT
ARG VERSION=latest

from golang:$GOLANG_VERSION-$DEBIAN_VERSION as BUILD

RUN apt update && apt -y install build-essential

# Make and install promu utility
RUN cd src && \
    git clone https://github.com/prometheus/promu && \
    cd promu && \
    make build && \
    cp -p promu /usr/bin

# Build dockerhub_exporter
RUN mkdir -p src/github.com/webhippie && \
    cd src/github.com/webhippie && \
    git clone https://github.com/promhippie/dockerhub_exporter.git && \
    cd dockerhub_exporter && \
    make test build

FROM alpine:$ALPINE_VERSION

# Run unprivileged
USER nobody

# Service runs on 9505/tcp
EXPOSE 9505

# Copy dockerhub_exporter binary from build image
COPY --from=BUILD /go/src/github.com/webhippie/dockerhub_exporter/dockerhub_exporter .

#CMD ["sh", "-c", "/dockerhub_exporter -dockerhub.org mesaguy"]
CMD ["/dockerhub_exporter", "-dockerhub.org", "mesaguy"]
