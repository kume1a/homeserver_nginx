# Legacy Nginx routing

This directory preserves the former public-IP routing setup. It is not part of
the active Cloudflare Tunnel deployment.

The legacy setup exposes Nginx on host port 80 and expects the router to forward
public port 4444 to that port. It proxies these paths to Schedly on the Docker
host:

- `/schedlyfrontend/` to `http://host.docker.internal:3000`
- `/schedlybackend/` to `http://host.docker.internal:8000`

To restore it intentionally from the repository root:

```sh
docker compose -f legacy/nginx/compose.yaml up --detach --build
```

Re-enable the router's `4444` to `80` port-forward separately if it has been
removed. Stop the legacy service with:

```sh
docker compose -f legacy/nginx/compose.yaml down
```
