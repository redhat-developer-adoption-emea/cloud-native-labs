#!/bin/bash

mkdir ./bin
curl -L -o ./bin/openapi-generator-cli.jar http://central.maven.org/maven2/org/openapitools/openapi-generator-cli/3.3.4/openapi-generator-cli-3.3.4.jar

java -jar ./bin/openapi-generator-cli.jar generate -i inventory.yaml -g aspnetcore -o inventory-gen