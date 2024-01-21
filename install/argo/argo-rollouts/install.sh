#!/bin/bash

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm upgrade --install argo-rollout argo/argo-rollouts --version 2.31.0 -n argo-rollouts --set "dashboard.enabled=false" --create-namespace
kubectl apply -f ./argo-rollouts-dashboard.yaml
