#!/bin/bash
#qIohj3q5D5BQksrf

snap add helm



helm repo add bitnami https://charts.bitnami.com/bitnami



# bootstrap juju to use the local LXD controller
juju bootstrap localhost overlord

# create model for PostreSQL K8s name 'tutorial'
juju add-model tutorial

# check status
juju status

# Documentation: https://canonical.com/data/docs/postgresql/k8s/t-deploy
# deploy postgres charm for microk8s
juju deploy postgresql-k8s --trust

# watch deployment status
#juju status --watch 1s


