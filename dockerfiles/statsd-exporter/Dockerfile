ARG PYTHON_BASE_IMAGE="ubuntu:20.04"

FROM ${PYTHON_BASE_IMAGE}


ARG ARCH="amd64"
ARG OS="linux"
COPY ./files/statsd_exporter /bin/statsd_exporter

USER        65534
EXPOSE      9102 9125 9125/udp
HEALTHCHECK CMD wget --spider -S "http://localhost:9102/metrics" -T 60 2>&1 || exit 1
ENTRYPOINT  [ "/bin/statsd_exporter" ]

