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

## Troubleshooting
# $ openssl s_client -showcerts -verify 5 -connect docker-registry-default.apps.serverless-ccf7.openshiftworkshop.com:443 < /dev/null
# Copy last CERT content to a file 'ca.crt', then copy that file to /etc/pki/ca-trust/source/anchors/
# $ cp ca.crt /etc/pki/ca-trust/source/anchors/
# $ update-ca-trust extract
# Restart docker 
# $ systemctl restart docker

export REGISTRY_URL=$(oc get routes -n default | grep docker-registry | awk '{print $2}')
docker login $REGISTRY_URL -u $(oc whoami) -p $(oc whoami -t)

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