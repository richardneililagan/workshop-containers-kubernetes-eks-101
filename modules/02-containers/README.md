Create a container executable
===

**Containers** allow you to package together an application and its dependencies,
in a thin, compact, distributable manner. 

Containers are run from an **image** --- you can think of an image as the blueprint from
where a container is created from. 

Putting together a container image ensures that your application will run virtually
exactly the same on any machine you can run the container from, without having to
install the dependencies of your application --- because those are already in the
container.

---
## Create a container image

Container images are created using a [Dockerfile][dockerfile] --- a plain text file
that contains instructions on how to put together the image.

Using the source files (`index.js` and `package.json`) provided in this module,
we can create a `Dockerfile` that builds a container image that runs this `Node.js`
application:

```Dockerfile
# :: put this in a file called Dockerfile
FROM node:14.15

WORKDIR app

COPY package.json .
RUN npm install

COPY index.js .

ENTRYPOINT ["node", "index.js"]
CMD ["1", "2"]
```

Then we can use our `Dockerfile` to build the container image like this:
```bash
docker build --tag my-image .
```

Once that builds, you can review your images by running:
```bash
docker images

---
REPOSITORY   TAG       IMAGE ID       CREATED          SIZE
my-image     latest    f172de97aa6f   41 seconds ago   943MB
node         14.15     995ff80c793e   2 days ago       942MB
```

You can create and run a container using any image by:
> **Tip:** The `--rm` flag here tells Docker to delete the container after it is done.
> By default, the container sticks around in a `STOPPED` state.
```bash
docker run --rm my-image

---
2
```

This outputs `2` because we've built our image so that the default arguments that are
given to the container are `1` and `2` (using the `CMD` instruction in the `Dockerfile`).

We can give different arguments too:
```bash
docker run --rm my-image 4 5 6

---
120
```

[dockerfile]: https://docs.docker.com/engine/reference/builder/
