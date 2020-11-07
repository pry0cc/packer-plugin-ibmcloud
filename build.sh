#!/bin/bash

echo "Building plugin... Will take a long time!"
docker build -t ibm/packer-plugin .
docker rm -f ibm-packer
docker run -d --name ibm-packer ibm/packer-plugin
arches=("darwin" "windows" "linux")
mkdir -p output

for arch in "${arches[@]}"
do
	docker cp ibm-packer:/root/go/src/github.com/ibmcloud/packer-builder-ibmcloud/packer-builder-ibmcloud-$arch output/packer-builder-ibmcloud-$arch
done

echo "Done, check output/"
