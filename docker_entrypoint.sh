#!/bin/sh
set -e

echo "Starting Grafana..."

# Ensure proper permissions for the persistent volume
chown -R grafana:grafana /var/lib/grafana

# Also ensure provisioning permissions just in case
chown -R grafana:grafana /etc/grafana/provisioning

# Drop privileges and run grafana
if command -v su-exec >/dev/null; then
    exec su-exec grafana /run.sh
elif command -v gosu >/dev/null; then
    exec gosu grafana /run.sh
else
    # Fallback using su
    exec su -s /bin/sh grafana -c "/run.sh"
fi
