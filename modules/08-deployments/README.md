Kubernetes Deployments
===

You generally don't create Pods directly --- most of the time it's much more effective
to manage your running Pods management objects like Deployments.

A **Deployment** allows you to tell your cluster your _desired_ state for a set of Pods.
From the information in a Deployment, your cluster will automatically do its best 
to maintain that state, no matter what happens.

If the cluster state deviates from your desired state, Kubernetes will automatically
make adjustments so that the state returns back to "normal".

---

## Use a Deployment to manage our Service Pods

Let's first delete our unmanaged Pods.
This will delete all Pods that have a label `app` set to `api` --- this is also the
selector that `service/api` is using.
```bash
kubectl delete pod -l app=api
```

Then create a manifest `api-deployment.yaml`:
```yaml
---
apiVersion: apps/v1
kind: Deployment

metadata:
  name: api-deployment
  labels:
    app: api

spec:
  replicas: 3
  selector:
    matchLabels:
      app: api
  template:
    # :: a Deployment's template section is a subset of the Pod manifest
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: api-container
          image: richardneililagan/06 # :: use your image
          ports:
            - containerPort: 8080     # :: make sure the port is correct
```

By now this should be second nature:
```bash
kubectl apply -f api-deployment.yaml
```

You can check the status of any Deployment using your staple `kubectl get` and
`kubectl describe` commands:
```bash
kubectl get deployment api-deployment
---
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
api-deployment   3/3     3            3           1m
```

This Deployment has `3/3` Pods ready / available. 
You can confirm that by querying your Pods directly as well:
```bash
kubectl get pods -l app=api
---
NAME                            READY   STATUS    RESTARTS   AGE
api-deployment-8676d4fd-99rzk   1/1     Running   0          1m
api-deployment-8676d4fd-bkfk6   1/1     Running   0          1m
api-deployment-8676d4fd-wtk6k   1/1     Running   0          1m
```

Try accessing your Service at this point, and confirm that you can reach the Pods
defined in this Deployment.

## Scale the Deployment

In a more real application, it's very rare that you need a fixed number of Pods
all the time. Chances are, the number of Pods you'll need to be running will change 
according to many different factors.

If you need to scale a Deployment, you can imperatively do this by:
```bash
kubectl scale deployment <name> --replicas=<amount>
```

... or you can declaratively do this by adjusting your manifest, then re-applying:
```bash
kubectl apply -f api-deployment.yaml
```

## Try:

- Force a few of your Pods to fail. What does the Deployment do?
