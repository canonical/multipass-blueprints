# Multipass Blueprints
This repository contains Multipass Blueprint definitions. They augment the offerings already available from the
[Ubuntu Cloud Images](https://cloud-images.ubuntu.com/). You can list the available images with
[`multipass find`](https://multipass.run/docs/find-command) and run them with [`multipass launch`](https://multipass.run/docs/launch-command):

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
The blueprints are defined in YAML of the following format (required fields marked with `*`):
```yaml
# v1/<name>.yaml

description: <string>      # * a short description of the blueprint ("tagline")
version: <string>          # * a version string

runs-on:                   # a list of architectures this blueprint can run on
- arm64                    #   see https://doc.qt.io/qt-5/qsysinfo.html#currentCpuArchitecture
- x86_64                   #   for a list of valid values

instances:
  <name>:                  # * equal to the blueprint name
    image: <base image>    # a valid image alias, see `multipass find` for available values
    limits:
      min-cpu: <int>       # the minimum number of CPUs this blueprint can work with
      min-mem: <string>    # the minimum amount of memory (can use G/K/M/B suffixes)
      min-disk: <string>   # and the minimum disk size (as above)
    timeout: <int>         # maximum time for the instance to launch, and separately for cloud-init to complete
    cloud-init:
      vendor-data: |       # cloud-init vendor data
        <string>

health-check: |            # a health-check shell script ran by integration tests
  <string>
```

## Testing
On Linux, the `multipass find` command looks for blueprints in a URL provided by an
environment variable, `MULTIPASS_BLUEPRINTS_URL`. To locally test your blueprints
you would need to override the systemd service with the following setting:

```conf
[Service]
Environment="MULTIPASS_BLUEPRINTS_URL=https://github.com/canonical/multipass-blueprints/archive/refs/heads/<BRANCH_NAME>.zip"
```

This can be done by using the `systemctl edit` utility to open the file and add the two lines mentioned above into the uncommented blank section:

```shell
sudo systemctl edit snap.multipass.multipassd.service
```

followed by service restart:

```shell
sudo snap restart multipass
```
