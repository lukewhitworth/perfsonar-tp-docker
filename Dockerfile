FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt full-upgrade -y && apt install software-properties-common gnupg curl vim -y
RUN add-apt-repository universe -y
RUN cd /etc/apt/sources.list.d/ && curl -o perfsonar-release.list http://downloads.perfsonar.net/debian/perfsonar-release.list && curl http://downloads.perfsonar.net/debian/perfsonar-official.gpg.key | apt-key add -
RUN apt update
RUN apt install -y perfsonar-testpoint perfsonar-toolkit-sysctl supervisor
RUN mkdir -p /var/run/pscheduler-server/ticker
RUN apt-get full-upgrade -y
RUN apt-get clean
RUN rm -Rf /var/lib/apt/lists/*

ADD overlay /

VOLUME /var/lib /var/log /run /tmp

# Copy our startup script
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
