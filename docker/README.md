# Dockerfile
This folder contains a Dockerfile which creates a Docker container with Litecoin 0.18.1 installed. Docker container is based on Debian 11 official images from [Dockerhub](https://hub.docker.com/_/debian)

Container has been built using a multi-stage approach: On the first stage, litecoin is downloaded. Once it's downloaded, integrity is checked using sha256sum and also GPG signature. If any of them fails, build will fail.
On the second stage, we're just copying litecoin daemon (litecoind) to a new container based on debian11-slim image, which allows to reduce the size of the final container reducing at the same time the attack surface. A new user is created for running litecoind unprivileged and [dumb-init](https://github.com/Yelp/dumb-init) is added into the container which has been previously downloaded on the first stage. Using dumb-init ensures that signals will be handled properly and it will ensure that zombie processes are reaped properly (if any).

You can build the image using the following:

    docker build -t litecoin .

And for running it just use the following:

    docker run litecoin

## Security
Apart for some sensible defaults like running the litecoin on the container using an unprivileged user, vulnerabilities have been checked on the resulting container.
For checking them, [grype](https://github.com/anchore/grype) was used. Decision was taken as grype it's easy to install but also allows to scan local images.
Grype can be installed using the following:

    curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin

Once installed, images can be scanned using:

    grype litecoin:latest

## Size
Multi-stage approach allows to decrease the size of the final image. Having smaller allows to reduce deployment times which can be critical during peak events, as you'll need to scale quickly. Also, you'll be able to reduce associated costs, as you'll need to use less space on your registry and less bandwith when pulling the images from your private registry
Using [dive](https://github.com/wagoodman/dive) it's easy to check the image size and if we can reduce even more the size of the image. In this case, according to dive, total image size is 92mb and we achieved a 99% of efficiency on the image size
