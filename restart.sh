#!/usr/bin/env bash
set -Eeuo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed or is not in PATH." >&2
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "The Docker daemon is unavailable to the current user." >&2
    exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
    echo "Docker Compose v2 is required." >&2
    exit 1
fi

echo "Building and deploying homeserver_nginx..."
docker compose build

container_name="homeserver_nginx"
compose_project="homeserver_nginx"

if docker container inspect "$container_name" >/dev/null 2>&1; then
    managed_by="$(
        docker container inspect \
            --format '{{ index .Config.Labels "com.docker.compose.project" }}' \
            "$container_name" 2>/dev/null || true
    )"

    if [[ "$managed_by" != "$compose_project" ]]; then
        echo "Replacing the legacy container: $container_name"
        docker container rm --force "$container_name"
    fi
fi

docker compose up --detach --no-build --remove-orphans --wait
docker compose ps

echo "Deployment completed successfully."
