#!/bin/bash

FROM_IMAGE_STREAM_FILE=redhat-openjdk-image-stream
TO_IMAGE_STREAM_FILE=${FROM_IMAGE_STREAM_FILE}-modified

TO_NAMESPACE=lab-infra
TO_IMAGE_STREAM=redhat-openjdk18-openshift
FROM_REGISTRY=registry.redhat.io/redhat-openjdk-18/openjdk18-openshift
TO_REGISTRY=docker-registry.default.svc:5000/${TO_NAMESPACE}/${TO_IMAGE_STREAM}