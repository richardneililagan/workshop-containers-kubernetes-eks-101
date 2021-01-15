Create a Kubernetes Cluster on Amazon EKS
===

---

## Use `eksctl` to set up your cluster infra

[`eksctl`][eksctl] is the official CLI tool for Amazon EKS --- among other useful
features, it allows you to create and set up the infrastructure required to run
a Kubernetes cluster on Amazon EKS.

Create a `cluster.yaml` file:
```yaml
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: eks-workshopper  # :: change the cluster name as you please
  region: ap-southeast-1 # :: make sure your region is correct
  version: '1.18'

# :: make sure your availability zones match your region
availabilityZones:
  - ap-southeast-1a 
  - ap-southeast-1b
  - ap-southeast-1c

managedNodeGroups:
  - name: default-ng
    desiredCapacity: 3

cloudWatch:
  clusterLogging:
    enableTypes: 
      - '*'
```

Then you can use that manifest file to create a cluster with `eksctl`:
```bash
# :: on your terminal
eksctl create cluster -f cluster.yaml
```

Creating the cluster will take about **~20 minutes**. 

When the cluster has been created, you can verify that it's available by running:

> **Rule of thumb**: `kubectl` is used to talk to your Kubernetes cluster,
> while `eksctl` is used to talk to whatever your cluster is running on top of. 

```bash
eksctl get clusters
---
NAME            REGION          EKSCTL CREATED
eks-workshopper	ap-southeast-1	True
```
```bash
kubectl get namespaces
---
NAME              STATUS   AGE
default           Active   5m
kube-node-lease   Active   5m
kube-public       Active   5m
kube-system       Active   5m 
```

[eksctl]: https://eksctl.io
