FROM ghcr.io/home-assistant/base:latest

ARG BUILD_VERSION
ARG BUILD_ARCH
ARG TUNNEL_CLIENT_VERSION="0.0.12"
ARG TUNNEL_CLIENT_SHA256="2bb693bd7b5cd28da7ce09cd9e309529dbb33b7cc9dc0058e62a064688f92c81"

LABEL \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.type="app" \
    io.hass.arch="${BUILD_ARCH}"

RUN apk add --no-cache ca-certificates curl unzip \
    && curl --fail --show-error --silent --location \
      --output /tmp/tunnel-client.zip \
      "https://github.com/openai/tunnel-client/releases/download/v${TUNNEL_CLIENT_VERSION}/tunnel-client-v${TUNNEL_CLIENT_VERSION}-linux-amd64.zip" \
    && echo "${TUNNEL_CLIENT_SHA256}  /tmp/tunnel-client.zip" | sha256sum -c - \
    && mkdir -p /tmp/tunnel-client /usr/share/licenses/tunnel-client \
    && unzip -q /tmp/tunnel-client.zip -d /tmp/tunnel-client \
    && install -m 0755 /tmp/tunnel-client/tunnel-client /usr/local/bin/tunnel-client \
    && install -m 0755 /tmp/tunnel-client/cloudflared /usr/local/bin/cloudflared \
    && install -m 0644 /tmp/tunnel-client/cloudflared-manifest.json /usr/share/licenses/tunnel-client/cloudflared-manifest.json \
    && install -m 0644 /tmp/tunnel-client/LICENSE /usr/share/licenses/tunnel-client/LICENSE \
    && install -m 0644 /tmp/tunnel-client/NOTICE /usr/share/licenses/tunnel-client/NOTICE \
    && rm -rf /tmp/tunnel-client /tmp/tunnel-client.zip \
    && apk del unzip

COPY run.sh /run.sh
RUN chmod 0755 /run.sh

CMD ["/run.sh"]
