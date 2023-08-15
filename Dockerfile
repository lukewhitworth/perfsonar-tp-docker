FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
  apt install --no-install-recommends -y software-properties-common gnupg curl && \
  add-apt-repository universe -y && \
  cd /etc/apt/sources.list.d/ && \
  curl -o perfsonar-release.list http://downloads.perfsonar.net/debian/perfsonar-release.list && \
  curl http://downloads.perfsonar.net/debian/perfsonar-official.gpg.key | apt-key add - && \
  apt update && \
  apt install --no-install-recommends -y perfsonar-testpoint perfsonar-toolkit-sysctl supervisor && \
  mkdir -p /var/run/pscheduler-server/ticker && \
  apt-get full-upgrade -y && \
  apt-get autoclean && \
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ADD overlay /
VOLUME /var/lib /var/log /run /tmp

# Copy our startup script
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]