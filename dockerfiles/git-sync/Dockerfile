ARG PYTHON_BASE_IMAGE="ubuntu:20.04"

FROM ${PYTHON_BASE_IMAGE}

RUN apt update
RUN DEBIOAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y tzdata
RUN apt upgrade -y
RUN apt install git -y
RUN apt install ca-certificates -y
RUN apt install logrotate -y
RUN apt -y install coreutils socat openssh-client
RUN apt -y install libexpat1 libkeyutils1 libpsl5 libssl1.1 libnghttp2-14 libcom-err2 libldap-common libkrb5support0 libsasl2-modules-db libwrap0 librtmp1 socat libpcre2-8-0 libk5crypto3 libsasl2-2 libssh2-1 libkrb5-3 openssl libbsd0 libgdbm6 libtinfo6 libedit2 libldap-2.4-2 ca-certificates libgssapi-krb5-2 libgdbm-compat4 openssh-client libcurl3-gnutls perl liberror-perl libc-bin ca-certificates git-man git
RUN apt -y install golang
RUN apt -y install musl openssh-server tini util-linux wireguard-tools

COPY ./files/git-sync /git-sync
COPY ./files/libperl5.28_5.28.1-6+deb10u1_amd64.deb /
COPY ./files/perl-modules-5.28_5.28.1-6+deb10u1_all.deb /
RUN chmod 766 /etc/passwd
RUN dpkg -i /perl-modules-5.28_5.28.1-6+deb10u1_all.deb
RUN dpkg -i /libperl5.28_5.28.1-6+deb10u1_amd64.deb
RUN apt -y install debconf
COPY --from=docker/buildx-bin:latest /buildx /



RUN groupadd -g 65533 git-sync
RUN  adduser --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password \
           --quiet "git-sync" --uid "65533" --gid "65533" --home "/tmp"
RUN usermod -a -G git-sync git-sync

RUN mkdir /tmp/git
RUN chown git-sync:git-sync /tmp/git
RUN chmod -R 777 /tmp/git

RUN chmod 666 /etc/passwd

USER 65533:65533
ENV HOME=/tmp
WORKDIR /tmp
ENV GIT_SYNC_ROOT=/tmp/git
ENTRYPOINT ["/git-sync"]
