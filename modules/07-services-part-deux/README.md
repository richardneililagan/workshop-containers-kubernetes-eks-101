# Kubernetes Services (again)

Ok, Services act as gateways to Pods, sure.
But we didn't really give a good solution for the problem in the last module ---
we still don't have a nice way to access Pods from outside the cluster. :thinking:

## Service types

When we looked at our Service earlier, we got this information back:
```bash
kubectl get service api
---
NAME   TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
api    ClusterIP   10.100.8.66   <none>        80/TCP    17h
```

For the observant, you'd have noticed that the Service we created was a `ClusterIP` type.

Kubernetes has four different kinds of native Service types:

### ClusterIP

This creates an internal cluster IP address that routes to your Pods.
If we don't specify a type, this is the default.

### NodePort

This assigns a port on the **Nodes** that automatically route to your Pods.
This way, you can talk to your Pods by talking to the Nodes' public IP address +
assigned port.

For example, if you have two Nodes, each with public IP addresses `1.2.3.4` and 
`5.6.7.8` respectively, and you create a `NodePort` Service that uses port `30000`,
then you can talk to the Pods selected by the Service by talking to either
`1.2.3.4:30000` or `5.6.7.8:30000`. 

### LoadBalancer

This creates a load balancer based on the implementation of the platform where your
cluster is running. Therefore, the exact behavior of this Service type is dependent
on where your cluster is.

On [Amazon EKS][eks], a `LoadBalancer` service will create standard [Amazon ELB][elb]
load balancers.

As you'd expect, talking to the load balancer will distribute requests to the 
Pods selected by the Service.

### ExternalName

Generally used for **internal to external** comms, this Service type maps an external
URL to an internal URL in the cluster.

---

## Try:

- Convert our Service from the last module to a `NodePort` service. 
  How do you access it now?
- Convert our Service now to a `LoadBalancer` service.
  How do you access it now?
- Wait --- what do you mean "external URL to an internal URL"?
  What are Kubernetes internal URLs? :thinking:

[eks]: https://aws.amazon.com/eks
[elb]: https://aws.amazon.com/elasticloadbalancing
