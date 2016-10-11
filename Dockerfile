FROM ubuntu:16.04
MAINTAINER Foucault de Bonneval <foucault(at)commit.ninja>

ARG application_version

COPY resources /tmp/resources

RUN /tmp/resources/build && rm -rf /tmp/resources

EXPOSE 10250
