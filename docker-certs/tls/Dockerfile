FROM alpine:3.10

WORKDIR /certs

ARG MKCERT_VERSION=1.4.1
RUN set -eux; \
	wget -O /usr/local/bin/mkcert https://github.com/FiloSottile/mkcert/releases/download/v$MKCERT_VERSION/mkcert-v$MKCERT_VERSION-linux-amd64; \
	chmod +x /usr/local/bin/mkcert; \
	mkcert --cert-file local-cert.pem --key-file local-key.pem mailhog.docker.localhost adminer.docker.localhost whoami.docker.localhost docker.localhost;

VOLUME /certs