#!/bin/sh

# Environment
. ./00-environment.sh

# WATCH OUT! >>> brew install python-yq

IMAGE_LIST=$(cat ${FROM_IMAGE_STREAM}.yaml | yq -r ".spec.tags[] | .from.name")

declare -a arr=(${IMAGE_LIST})

## now loop through the above array
for i in ${arr[@]}
do
   echo "Pulling, saving, compressing $i"
   docker pull $i
   FILE_NAME=$(echo $i | sed 's@/@_@g' | sed 's@:@__@g')
   docker save -o ${FILE_NAME}.tar $i
   tar zcvf ${FILE_NAME}.tar.gz ${FILE_NAME}.tar 
done