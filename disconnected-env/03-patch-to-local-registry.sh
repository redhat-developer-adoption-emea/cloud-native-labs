#!/bin/sh

# Environment
. ./00-environment.sh

# WATCH OUT! >>> brew install python-yq

sed "s@name: ${FROM_REGISTRY}@name: ${TO_REGISTRY}@g" ${FROM_IMAGE_STREAM}.yaml > ${TO_IMAGE_STREAM}.yaml