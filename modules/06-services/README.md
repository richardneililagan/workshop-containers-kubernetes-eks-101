Kubernetes Services
===

Kubernetes clusters maintain their own (internal) networking layers.
By default, objects inside a cluster are only available from inside the cluster.

Recall that we had to forward a port from our `nginx` pod to our local machine
so that we can talk to it:
```bash
kubectl port-forward --address 0.0.0.0 pod/my-nginx 8080:80
```

## Network gateways

Kubernetes **Services** act as gateways, most often to Pods running in your cluster.
You can then configure these "gateways" to best function according to your network needs.

Network packets received by a Service are redirected to Pods that they apply to.
Because Pods (and containers!) are designed to be temporary and ephemeral, they can
change names, IP addresses, etc. very often --- Services act as a more permanent,
reliable means of talking to whatever Pods are running in your cluster at any time.

---

## Run a Kubernetes Service

Create a file `api-service.yaml`:
```yaml
---
apiVersion: v1
kind: Service

metadata:
  name: api

spec:
  selector:
    app: api
  ports:
    - port: 80
      targetPort: 8080
```

Then, just like before, apply that to your cluster:
```bash
kubectl apply -f api-service.yaml
```

Your cluster will report back that the service is now running.
Let's get its IP address in the cluster:
```bash
kubectl get service api
---
NAME   TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
api    ClusterIP   10.100.8.66   <none>        80/TCP    17h
```

That IP address is not going to be reachable from outside the cluster.

So let's tunnel into a container running inside the cluster:
```bash
kubectl run bastion -it --image=curlimages/curl -- sh
# :: if you're already running the bastion pod, then you can just re-attach:
#    kubectl attach -it pod/bastion
```

Then try to talk to the Service:
```bash
# :: change this to the IP address you get above
curl 10.100.8.66
```

You will get an error (**Question**: Why?)

---

## Specify which Pods to use for a Service

Services determine which Pods to redirect network requests to using a **selector**.

The Service we created above had the following selector:
```yaml
spec:
  selector:
    app: api
```

This means that this Service will redirect network requests to any healthy Pod
that has a **label** `app` with the value `api`.

Let's try that out --- let's deploy your container from **Module 03** as a Pod
using a manifest `api-pod.yaml`:
```yaml
---
apiVersion: v1
kind: Pod

metadata:
  name: mark
  labels:       # ┐
    name: mark  # │ labels are placed in the metadata of an object
    app: api    # ┘ 

spec:
  containers:
    - name: mark
      image: richardneililagan/03 # :: use your own image
      ports:
        - containerPort: 8080 # :: make sure your port is correct
```

Apply that to the cluster:
```bash
kubectl apply -f api-pod.yaml
```

Once the Pod is up, try talking to your Service again.

---

## Try: 

- What happens if there are more than one Pod behind a Service?
- Can I create a Service that selects more than one label?
