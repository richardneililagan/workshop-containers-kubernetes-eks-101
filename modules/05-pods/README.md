Kubernetes Pods
===

A Kubernetes **Pod** is a group of one or more containers,
with shared storage and network resources, and run in a shared context.

A Pod is the analog for a logical host for a single application.

A Pod is also the smallest deployable unit of computing that you can
create and manage in Kubernetes.

---

## Run a container image locally

Remember how we can run a container locally on our machine?

```bash
# :: runs a bare nginx server, forwarding a port on our machine
#    to port 80 inside the container
docker run --rm -d -p 8000:80 nginx:1.14.2
```

How do we do the same on a Kubernetes cluster?

## Run a container in a Kubernetes pod

Create a file `nginx-pod.yaml`:

```yaml
---
apiVersion: v1
kind: Pod

metadata:
  name: my-nginx

spec:
  containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
        - containerPort: 80
```

Then apply that to your cluster:

```bash
kubectl apply -f nginx-pod.yaml
```

You can then reach the `nginx` server by forwarding the pod container's ports:

```bash
kubectl port-forward --address 0.0.0.0 pod/my-nginx 8080:80
```

## Try:

- Create your own image, push to a registry, then use that in a Pod
