# Multipass Workflows
This repository contains multipass workflow definitions.
Multipass workflows augment the offerings already available from the
[Ubuntu Cloud Images](http://cloud-images.ubuntu.com/). You can list the available images with
[`multipass find`](https://multipass.run):

```plain
$ multipass find
Image                       Aliases           Version          Description
# ...
minikube                                      latest           minikube is local Kubernetes

$ multipass launch minikube
Launched: minikube

$ multipass exec minikube -- minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

## Schema
The workflows are defined in YAML of the following format (required fields marked with `*`):
```yaml
# v1/<name>.yaml

description: <string>      # * a short description of the workflow ("tagline")
version: <string>          # * a version string

instances:
  <name>:                  # * equal to the workflow name
    image: <base image>    # a valid image alias, see `multipass find` for available values
    limits:
      min-cpu: <int>       # the minimum number of CPUs this workflow can work with
      min-mem: <string>    # the minimum amount of memory (can use G/K/M/B suffixes)
      min-disk: <string>   # and the minimum disk size (as above)
    timeout: <int>         # maximum time for the instance to launch, and separately for cloud-init to complete
    cloud-init:
      vendor-data: |       # cloud-init vendor data
        <string>
```

## Build multipass-compatible images
Images can be [built with Packer](https://discourse.ubuntu.com/t/building-multipass-images-with-packer/12361).
