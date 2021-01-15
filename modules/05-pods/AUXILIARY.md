Kubernetes Pods
===

## `kube-ops-view`

The Kubernetes Operational View (`kube-ops-view`) is a simple visualization 
of what's happening in a Kubernetes cluster.

![](https://codeberg.org/hjacobs/kube-ops-view/media/branch/main/screenshot.png)

### Prerequisite: Install `metrics-server`

```bash
# :: https://github.com/kubernetes-sigs/metrics-server#installation 
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### Install `kube-ops-view`

```bash
# :: clone the kube-ops-view repository somewhere
git clone https://codeberg.org/hjacobs/kube-ops-view.git
cd kube-ops-view

# :: apply the artifacts into your kubernetes cluster
kubectl apply -k deploy

# :: forward a port connection to your machine
#    (change 8080 to a port of your choosing, if you'd like)
kubectl port-forward --address 0.0.0.0 service/kube-ops-view 8080:80
```
