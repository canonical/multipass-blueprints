#!/bin/bash

# Install Helm if not already installed
if ! command -v helm &> /dev/null
then
    echo "Helm not found. Installing Helm."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
else
    echo "Helm is already installed."
fi

# Ensure microk8s is up and running
echo "Ensuring MicroK8s is ready..."
microk8s status --wait-ready

# Enable necessary MicroK8s services
echo "Enabling MicroK8s services..."
microk8s enable helm3
microk8s enable dns
microk8s enable storage

# Ensure helm is pointing to microk8s
echo "Setting up Helm to use MicroK8s..."
microk8s helm3 repo update

# Add the Apollo Router Helm repository
echo "Adding Apollo Router Helm repository..."
helm repo add apollo-router oci://ghcr.io/apollographql/helm-charts

# Update Helm repositories
echo "Updating Helm repositories..."
helm repo update

# Install Apollo Router using Helm
echo "Installing Apollo Router..."
helm install apollo-router apollo-router/router

echo "Apollo Router installation complete."
