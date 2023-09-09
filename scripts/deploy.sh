#!/bin/bash

export IMAGE=$(echo $1 | awk -F https:// '{ print $NF }')
kubectl delete all --all -n devsecops
envsubst < deployment.yaml | kubectl -n devsecops apply -f -
