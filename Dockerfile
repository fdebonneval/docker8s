FROM ubuntu:16.04
MAINTAINER Foucault de Bonneval <foucault(at)commit.ninja>

ARG application_version

RUN apt-get update && \
    apt-get install -y curl iptables && \
    curl -sL -o bin/hyperkube \
    https://storage.googleapis.com/kubernetes-release/release/v${application_version}/bin/linux/amd64/hyperkube && \
    chmod 755 bin/hyperkube

EXPOSE 10250
