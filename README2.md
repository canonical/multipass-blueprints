To include the installation and setup of the PostgreSQL charm in your Kubernetes (k8s) cluster using Ubuntu Multipass and a `charm-dev` blueprint, follow these steps:

### Prerequisites
Ensure you have the following installed on your host machine:
- Ubuntu Multipass
- Juju (for deploying charms)
- MicroK8s (or any other Kubernetes distribution)

### Step 1: Create and configure the `charm-dev` Multipass instance

If you haven't already set up a `charm-dev` instance, you can create one using the following command:

```bash
multipass launch --name charm-dev --cpus 2 --mem 4G --disk 20G
```

### Step 2: Access the `charm-dev` instance

```bash
multipass shell charm-dev
```

### Step 3: Install and configure MicroK8s

Inside the `charm-dev` instance, install MicroK8s:

```bash
sudo snap install microk8s --classic
```

Add the current user to the `microk8s` group to avoid needing `sudo`:

```bash
sudo usermod -a -G microk8s $USER
newgrp microk8s
```

Enable the necessary MicroK8s addons:

```bash
microk8s enable dns storage
```

### Step 4: Install Juju

Install Juju on the `charm-dev` instance:

```bash
sudo snap install juju --classic
```

### Step 5: Bootstrap Juju on MicroK8s

Bootstrap Juju to use MicroK8s as the Kubernetes provider:

```bash
juju bootstrap microk8s microk8s-controller
```

### Step 6: Add a model for PostgreSQL

Create a new Juju model for PostgreSQL:

```bash
juju add-model postgresql-model
```

### Step 7: Deploy the PostgreSQL charm

Deploy the PostgreSQL charm using Juju:

```bash
juju deploy postgresql-k8s
```

### Step 8: Verify the deployment

Check the status of the deployment to ensure everything is running correctly:

```bash
juju status
```

### Step 9: Configuring PostgreSQL (Optional)

If you need to configure PostgreSQL, you can use Juju configuration options. For example, to set a custom database name:

```bash
juju config postgresql-k8s database-name=mydatabase
```

### Automating the Setup

To automate these steps in your `charm-dev` blueprint, you can use cloud-init to provision the `charm-dev` instance with the necessary packages and configurations. Create a cloud-init configuration file (e.g., `cloud-init.yaml`) with the following content:

```yaml
#cloud-config
packages:
  - snapd

runcmd:
  - snap install microk8s --classic
  - usermod -a -G microk8s ubuntu
  - newgrp microk8s
  - microk8s enable dns storage
  - snap install juju --classic
  - juju bootstrap microk8s microk8s-controller
  - juju add-model postgresql-model
  - juju deploy postgresql-k8s
  - juju config postgresql-k8s database-name=mydatabase
```

### Step 10: Launch the Multipass instance with cloud-init

Launch the `charm-dev` instance with the cloud-init configuration:

```bash
multipass launch --name charm-dev --cpus 2 --mem 4G --disk 20G --cloud-init cloud-init.yaml
```

This will set up the instance, install MicroK8s and Juju, bootstrap Juju, create a model, and deploy the PostgreSQL charm automatically.

### Summary

By following these steps, you can set up a Kubernetes cluster with a PostgreSQL database using Ubuntu Multipass and Juju charms. The cloud-init configuration automates the process, making it easy to replicate the setup in future environments.