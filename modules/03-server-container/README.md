Create a container that runs a web server
===

Containers don't just have to be one-off executables --- they can also run long-running
applications (like web servers).

---

> **Try**: Create an image using the source files in this module

## Running a container with a persistent process

When running a container with a persistent process (like a webserver), it's oftentimes
easier if you run using an interactive terminal (`docker run -it` --- `-it` technically
means "interactive TTY") or as a background process (`docker run -d` --- `-d` stands
for "detached").

Running the container using `-it` connects your terminal shell to the process inside 
the container. You can detach (without stopping the container) by pressing
`CTRL+P CTRL+Q`.

You can inspect all your running containers using:
```bash
docker ps

---
CONTAINER ID   IMAGE     COMMAND        CREATED         STATUS         PORTS     NAMES
9518eaab4792   server    "node index"   5 minutes ago   Up 5 minutes             recursing_albattani
```

## Expose a port into the container

As it is, our container doesn't really do anything very useful, because the network 
inside the running container is private only to the container --- so we can't even
talk to the server running inside!

Let's stop our running container first:
```bash
docker stop 9518 # <-- use your container ID!
```

We can expose a port in a container by using the `-p` flag:
```bash
# -p <HOST PORT>:<CONTAINER PORT>
docker run -it --rm -p 8080:8080 server
```

---

## Try:
- Build a container image that serves a [Create React App][cra]-based webapp.
- Using a multi-stage build to optimize the image / use different technologies.

[cra]: https://create-react-app.dev
