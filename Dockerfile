FROM grafana/grafana:latest

USER root
# Install su-exec for dropping privileges in entrypoint (Alpine based image usually)
RUN apk add --no-cache su-exec || apt-get update && apt-get install -y gosu || true

COPY docker_entrypoint.sh /docker_entrypoint.sh
RUN chmod +x /docker_entrypoint.sh

COPY provisioning/ /etc/grafana/provisioning/

ENTRYPOINT ["/docker_entrypoint.sh"]
