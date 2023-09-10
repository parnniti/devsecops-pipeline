#!/bin/bash

export IMAGE=$(echo $1 | awk -F https:// '{ print $NF }')

kubectl create ns $APP_NAMESPACE || true
kubectl delete all --all -n $APP_NAMESPACE
envsubst < deployment.yaml | kubectl -n $APP_NAMESPACE apply -f -
