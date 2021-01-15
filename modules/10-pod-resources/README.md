Pod Resources
===

Pods (technically, the containers in them) need resources to run.
Kubernetes lets you specify just how much each Pod will need.

## Requests and Limits

When creating Pods, you can tell Kubernetes how much resource (e.g. CPU and memory)
each Pod needs:

- **Requests** are the specified _minimum_. Kubernetes allocates this when running 
  a Pod.
- **Limits** are the _maximum_. If the Pod exceeds this, Kubernetes forcibly kills
  the Pod.

---

## Specify resource requests on our Deployment

Let's adjust our Deployment so that our Pods explicitly are assigned a 
CPU resource request:
```yaml
spec:
  template:
    spec:
      resources:
        requests:
          cpu: 250m
      containers: # ...
```

Then re-apply that:
```bash
kubectl apply -f api-deployment.yaml
```
