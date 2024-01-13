#!/bin/bash

helm install argo-rollout argo/argo-rollouts --version 2.31.0 -n argo-rollouts --set "dashboard.enabled=true" --create-namespace
