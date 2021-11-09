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

