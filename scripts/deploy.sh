#!/bin/bash

export IMAGE=$(echo $1 | awk -F https:// '{ print $NF }')
NAMESPACE=devsecops

kubectl create ns $NAMESPACE 2> /dev/null || true
kubectl delete all --all -n $NAMESPACE
envsubst < deployment.yaml | kubectl -n $NAMESPACE apply -f -
