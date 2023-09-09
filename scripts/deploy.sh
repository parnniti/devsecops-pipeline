#!/bin/bash

kubectl delete all --all -n devsecops
envsubst < deployment.yaml | kubectl -n devsecops apply -f -
