# agendav-docker
Docker image for agendav

Since this image only carries a front-end for CalDAV, there's no provision for persistency. Running agendav statelessly has no drawbacks since agendav itself is not very customizable.

Image is not optimized for size or compilation time. Standard `debian:wheezy` base image is used. Final image size is `391MB`.

I know it's terrible and I don't care.
