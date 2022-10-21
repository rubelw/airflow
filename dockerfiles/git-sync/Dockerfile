ARG PYTHON_BASE_IMAGE="ubuntu:20.04"

FROM ${PYTHON_BASE_IMAGE}

RUN apt update
RUN DEBIOAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y tzdata
RUN apt install git -y


COPY ./files/git-sync /git-sync

RUN groupadd -g 65533 git
RUN  adduser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password \
           --quiet "git" --uid "65533" --gid "65533" --home "/tmp/git"

RUN mkdir /git
RUN chown git:git /git
USER 65533:65533
ENV HOME=/tmp
WORKDIR /tmp
ENV GIT_SYNC_ROOT=/tmp/git
ENTRYPOINT ["/git-sync"]
