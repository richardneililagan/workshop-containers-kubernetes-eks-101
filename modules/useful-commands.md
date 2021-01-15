Auxiliary Useful Commands 
===

## Provide cluster access to another IAM user

The AWS IAM user that created the EKS cluster will automatically have admin access on
it, but if you want to also allow another AWS IAM user access to the cluster, you can
explicitly grant (or revoke!) it.

```bash
eksctl create iamidentitymapping \
  --arn arn:aws:iam::123456789012:user/username \
  --cluster my-cluster \
  --username some-username \
  --groups system:masters
```

## Run a `bash` shell on a new container in a cluster

```bash
kubectl run bastion -it --image=curlimages/curl -- sh
# :: the pod called 'bastion' will run in your cluster, 
#    and keep an interactive terminal open to it
```

To detach from the shell, run `exit` in the shell.

To (re)attach to your bastion:
```bash
kubectl attach -it pod/bastion
```
