#!/bin/bash

FROM_IMAGE_STREAM=redhat-openjdk-image-stream
TO_IMAGE_STREAM=${FROM_IMAGE_STREAM}-modified

TO_NAMESPACE=lab-infra
FROM_REGISTRY=registry.redhat.io/redhat-openjdk-18/openjdk18-openshift
TO_REGISTRY=docker-registry.default.svc:5000/${TO_NAMESPACE}/redhat-openjdk18-openshift