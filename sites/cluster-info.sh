#!/bin/bash
terraform output -raw kube_config > ~/.kube/config
kubectl cluster-info

