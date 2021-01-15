Kubernetes Deployments (again)
===

Deployments don't just manage the number of Pods that are running in your cluster ---
as the name implies, they also abstract details of how your resources are, um, 
deployed. :laughing:

## Let's update our Deployment

Imagine we needed to roll out a new change on our Pods.
In this case, we'd like to change the container port used by our Pods.

In `api-deployment.yaml`:
```yaml
# change this in .spec.template:
spec:
  containers:
    - name: api-container
      ports:
        - containerPort: 9090
      # ...
```

To update our Deployment, we just need to reapply the manifest file:
```bash
kubectl apply -f api-deployment.yaml
```

But wait --- now our `service/api` is broken! :warning::warning::warning:

> **Question**: Why is it now broken?

## Rollback a problematic update

Kubernetes maintains a history of Deployment updates (called **Rollouts**).
You can review our Deployment's rollout history by:
```bash
kubectl rollout history deployment api-deployment
```

You can also check the status of the current rollout by:
```bash
kubectl rollout status deployment api-deployment
```

Since we realize that we have just updated a faulty deployment, 
we can rollback to the previous revision using:
```bash
kubectl rollout undo deployment api-deployment
```

> Alternatively, you can rollback to any point in the history by:
> ```bash
> kubectl rollout undo deployment api-deployment --to-revision=<revision number>
> ```
