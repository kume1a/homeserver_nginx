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

: "${CLOUDFLARE_TUNNEL_TOKEN:?CLOUDFLARE_TUNNEL_TOKEN is required}"

echo "Deploying Cloudflare Tunnel..."
docker compose up --detach --remove-orphans --wait
docker compose ps

echo "Deployment completed successfully."
