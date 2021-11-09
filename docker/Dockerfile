FROM debian:11 as builder
RUN apt update && apt install -y wget gpg
WORKDIR /tmp
RUN wget https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-linux-signatures.asc
RUN wget https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-x86_64-linux-gnu.tar.gz
RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/local/bin/dumb-init
RUN wget https://download.litecoin.org/litecoin-0.18.1/SHA256SUMS.asc
RUN sha256sum --check --ignore-missing SHA256SUMS.asc
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys FE3348877809386C
RUN gpg --verify litecoin-0.18.1-linux-signatures.asc
RUN tar -xvf litecoin-0.18.1-x86_64-linux-gnu.tar.gz && chmod a+x /tmp/litecoin-0.18.1/bin/litecoind

FROM debian:11-slim
ARG user=litecoin
ARG group=litecoin
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group} && useradd -u ${uid} -g ${group} -s /bin/sh -d /home/litecoin -m ${user}
WORKDIR /home/litecoin
COPY --from=builder /usr/local/bin/dumb-init /usr/local/bin/dumb-init
COPY --from=builder --chown=litecoin:litecoin /tmp/litecoin-0.18.1/bin/litecoind /home/litecoin/litecoind
USER litecoin
EXPOSE 9333
ENTRYPOINT [ "/usr/local/bin/dumb-init", "--" ]
CMD ["/home/litecoin/litecoind"]
