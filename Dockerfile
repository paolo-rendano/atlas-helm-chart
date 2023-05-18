FROM openjdk:8-jdk-alpine

# Install required packages for installation
RUN apk add --no-cache \
    bash \
    su-exec \
    python \
    git \
    tar \
    maven

COPY ./apache-atlas-2.3.0-server.tar.gz /
RUN ls -la /

# Unarchive
RUN set -x \
    && cd / \
    && mkdir apache-atlas \
    && tar xvzf /apache-atlas-2.3.0-server.tar.gz -C /apache-atlas --strip-components 1 \
    && rm /apache-atlas-2.3.0-server.tar.gz

WORKDIR /apache-atlas

EXPOSE 21000

ENV PATH=$PATH:/apache-atlas/bin

CMD ["/bin/bash", "-c", "/apache-atlas/bin/atlas_start.py; tail -fF /apache-atlas/logs/application.log"]
