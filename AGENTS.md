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
  The default value must build correctly without any `--build-arg`, because CI
  passes no build arguments.
- A Grafana bump changes `GRAFANA_VERSION` in `VERSION`, the `ARG` default and
  the README. CI reads the tags from `VERSION`.
- A plugin change touches `GRAFANA_PLUGINS` in the `Dockerfile` and the plugin table
  in `README.md`. `tests/smoke.sh` checks every plugin in the image.
- Do not delete files from an installed plugin. Grafana rejects the plugin
  (`signatureModified`).
- `VERSION` holds the release date and `GRAFANA_VERSION`. `make release` sets
  the date. CI pushes `latest` also as `<VERSION>`, `<GRAFANA_VERSION>` and
  `<GRAFANA_VERSION>-<VERSION>`, and creates the GitHub release.
- CI builds every branch. Only master is pushed to Docker Hub.
- Run `make build test test-docker` before you commit.
