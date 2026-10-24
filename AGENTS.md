# AGENTS.md

Grafana Docker image with plugins installed at build time, published as `dockette/grafana`.

## Writing style

- Write in ASD-STE100 (Simplified Technical English).
- Follow Zinsser's four principles of quality writing:
  1. Simplicity
  2. Brevity
  3. Clarity
  4. Humanity

## Conventions

- Install every plugin at build time. Do not add anything that downloads at start.
- Plugins go into `/opt/grafana/plugins` (`GF_PATHS_PLUGINS`), not `/var/lib/grafana`,
  because users mount a volume on `/var/lib/grafana`.
- Pin every plugin version in the `Dockerfile`.
- Do not override the upstream entrypoint, command, workdir or exposed port.
- The upstream version is pinned in `ARG GRAFANA_VERSION` in the `Dockerfile`.
  The default value must build correctly without any `--build-arg`, because the
  shared workflow in `dockette/.github` cannot pass build arguments.
- A Grafana bump touches four places: the `ARG` default, `GRAFANA_VERSION` and
  `DOCKER_TAG` in the `Makefile`, the `tag` matrix in `.github/workflows/docker.yml`,
  and the tables in `README.md`.
- A plugin change touches `GRAFANA_PLUGINS` in the `Dockerfile` and the plugin table
  in `README.md`. `tests/smoke.sh` checks every plugin in the image.
- Do not delete files from an installed plugin. Grafana rejects the plugin
  (`signatureModified`).
- `VERSION` is the release date; `make release` bumps it. CI pushes `latest`
  also as `<VERSION>` and creates the GitHub release.
- CI builds every branch. Only master is pushed to Docker Hub.
- Run `make build test test-docker` before you commit.
