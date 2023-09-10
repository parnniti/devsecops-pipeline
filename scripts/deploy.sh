#!/bin/bash

export IMAGE=$(echo $1 | awk -F https:// '{ print $NF }')
NAMESPACE=devsecops

kubectl create ns $NAMESPACE || true
kubectl delete all --all -n $NAMESPACE
envsubst < deployment.yaml | kubectl -n $NAMESPACE apply -f -
