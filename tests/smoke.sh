#!/usr/bin/env sh
# Smoke test for the image. Usage: IMAGE=dockette/grafana:13.2.3 ./tests/smoke.sh
set -eu

IMAGE="${IMAGE:-dockette/grafana:latest}"
NAME="${NAME:-grafana-smoke}"
TIMEOUT="${TIMEOUT:-90}"

cleanup() {
    docker rm -f "$NAME" > /dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

cleanup

echo "> start ${IMAGE}"
docker run -d --name "$NAME" --network none "$IMAGE" > /dev/null

api() {
    docker exec "$NAME" wget -qO- --header "Authorization: Basic YWRtaW46YWRtaW4=" "http://127.0.0.1:3000$1"
}

echo "> wait for /api/health"
i=0
until api /api/health > /dev/null 2>&1; do
    i=$((i + 1))
    if [ "$i" -ge "$TIMEOUT" ]; then
        echo "! grafana did not start" >&2
        docker logs "$NAME" >&2
        exit 1
    fi
    sleep 1
done

PLUGINS=$(docker exec "$NAME" ls /opt/grafana/plugins)
for p in $PLUGINS; do
    echo "> plugin ${p}"
    api "/api/plugins/${p}/settings" | grep -q "\"id\":\"${p}\"" \
        || { echo "! plugin ${p} not loaded" >&2; docker logs "$NAME" >&2; exit 1; }
done

echo "> plugin errors"
errors=$(api /api/plugins/errors)
[ "$errors" = "[]" ] || { echo "! plugin errors: ${errors}" >&2; exit 1; }

echo "> ok"
