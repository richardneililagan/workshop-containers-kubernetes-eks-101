Horizontal Autoscaling
===

### How many Pods should you be running for an application?

On a live, production system, oftentimes there's no easy answer to this question.
The number of users using your apps at any given time (and what exactly they're 
doing on your app) continuously changes. People go to sleep and wake up, and oftentimes
usage depends on some real world phenomenon, like paydays, or weekends and holidays,
or maybe something as benign as a popular personality tweeting about your service.

It's because of these things that generally we don't want a fixed number of Pods
running --- instead, we prefer to have the number of Pods change based on some real
measurement (like website traffic). Even better if this can be done automatically.

This is what **autoscaling** tries to solve.

---

## Create a mock application with a heavy computation

Let's build a small application that simulates some heavy backend work.

The source files `index.js`, `package.json`, and `Dockerfile` in this module can be
built to create a simple web server that listens on port `8080`. When an `HTTP GET /`
is received, the application generates **10,000,000** random numbers, then responds
with the last one generated.

After you push your container image to your registry, let's create a Deployment
and Service for it using a manifest file `randomizer.yaml`:

```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: randomizer
  labels:
    app: randomizer

spec:
  replicas: 1
  selector: 
    matchLabels:
      app: randomizer
  
  template:
    metadata:
      labels:
        app: randomizer
    spec:
      containers:
        - name: server
          image: richardneililagan/randomizer # :: <-- use your own image name
          ports:
            - containerPort: 8080
          resources:
            requests:
              cpu: 200m

---
apiVersion: v1
kind: Service
metadata:
  name: randomizer

spec:
  selector:
    app: randomizer
  ports:
    - port: 80
      targetPort: 8080
```

Then apply that to your cluster:
```bash
kubectl apply -f randomizer.yaml
```

> **Try**: Ensure that the Service is running correctly, and that you can get
> a response from the Pods.

## Create a horizontal scaling policy

A `HorizontalPodAutoscaler` is a Kubernetes object that watches over a Deployment,
and automatically adjusts the number of Pods in it. It does this by watching some
measurement you provide, and making adjustments based on how that measurement is
performing.

Create a `randomizer-hpa.yaml` file:
```yaml
---
apiVersion: autoscaling/v2beta2
kind: HorizontalPodAutoscaler

metadata:
  name: randomizer

spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: randomizer

  minReplicas: 1
  maxReplicas: 10

  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
```

Then, as before, apply that to the cluster:
```bash
kubectl apply -f randomizer-hpa.yaml
```
