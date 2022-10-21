ARG PYTHON_BASE_IMAGE="ubuntu:20.04"

FROM ${PYTHON_BASE_IMAGE}


ARG ARCH="amd64"
ARG OS="linux"
COPY ./files/pgbouncer_exporter /bin/pgbouncer_exporter

USER       nobody
ENTRYPOINT ["/bin/pgbouncer_exporter"]
EXPOSE     9127
