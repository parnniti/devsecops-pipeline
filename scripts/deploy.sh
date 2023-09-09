#!/bin/bash

export IMAGE=$(echo $DOCKER_REGISTRY/$1 | awk -F https:// '{ print $NF }')
kubectl delete all --all -n devsecops
envsubst < deployment.yaml | kubectl -n devsecops apply -f -
