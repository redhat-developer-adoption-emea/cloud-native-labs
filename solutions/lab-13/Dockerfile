#FROM registry.access.redhat.com/openshift3/jenkins-agent-nodejs-8-rhel7:v3.10
FROM openshift/jenkins-agent-nodejs-8-centos7:v3.10

MAINTAINER Carlos Vicens <cvicensa@redhat.com>

ENV PATH=/opt/rh/rh-nodejs8/root/usr/bin:${PATH}

USER root

COPY google-chrome.repo  /etc/yum.repos.d/google-chrome.repo

#RUN yum install -y epel-release && yum install -y chromium && npm install -g @angular/cli@latest
RUN yum install -y google-chrome-stable

USER 1001


RUN mkdir ~/.npm-global && npm config set prefix '~/.npm-global' && npm install -g @angular/cli@latest