Container Image Registries
===

> **IMPORTANT**<br>
> An image's complete name dictates the registry where it is stored (pushed and pulled).
>
> To give an image another name (alias / tag):
> ```bash
> docker tag <current image name> <new image name>
> # :: e.g.
> #    docker tag richardneililagan/01 richardneililagan/nadine
> ```

## Using Docker Hub (hub.docker.com)

1. Create a user account on [Docker Hub][dockerhub].
2. Authenticate your machine with Docker Hub.
   ```bash
   docker login
   # :: follow the prompts to authenticate using your new account
   ```
3. Upload (push) your images into Docker Hub.
   ```bash
   docker push <image tag>
   # :: e.g. 
   #    docker push richardneililagan/soldam:latest
   ```

## Using Amazon Elastic Container Registry (ECR)

1. Go to your [Amazon ECR Console][ecr-console].
2. Go to **Repositories** from the left-sidebar. 
3. Click `Create repository`.
4. Give your repository a name. (e.g. `sodam/park`).
   Click `Create repository` at the bottom to confirm.

To push images to the repository, click your newly-created repository,
then click `Push commands` at the top to view the process.

> **IMPORTANT**<br>
> To be able to push to this repository, your image name has to have your 
> repository's URL.
>
> e.g.<br>
> `docker push 1234.dkr.ecr.ap-southeast-1.amazonaws.com/sodam/park:latest`

---

[dockerhub]: https://hub.docker.com
[ecr-console]: https://console.aws.amazon.com/ecr 
