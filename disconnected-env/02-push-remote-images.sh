#!/bin/sh

# Environment
. ./00-environment.sh

# WATCH OUT! >>> brew install python-yq

#oc login https://occon.enp.aramco.com.sa -u admin

TOKEN=$(oc whoami -t)

if [ -z ${TOKEN} ]; then
echo "You need to log as admin in your Openshift cluster first..."
exit 1
fi

export REGISTRY_URL=$(oc get routes -n default | grep docker-registry | awk '{print $2}')
docker login $REGISTRY_URL -u admin -p $(oc whoami -t)

IMAGE_LIST=$(cat ${FROM_IMAGE_STREAM}.yaml | yq -r ".spec.tags[] | .from.name")

declare -a arr=(${IMAGE_LIST})

## now loop through the above array
for i in ${arr[@]}
do
   echo "Decompressing, saving, compressing $i"
   FILE_NAME=$(echo $i | sed 's@/@_@g' | sed 's@:@__@g')
   tar zxvf ${FILE_NAME}.tar.gz
   docker load -i ${FILE_NAME}.tar
   docker tag $i $REGISTRY_URL/${TO_NAMESPACE}/$i
   docker push $REGISTRY_URL/${TO_NAMESPACE}/$i
done