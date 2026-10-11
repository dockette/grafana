<h1 align=center>Dockette / Grafana</h1>

<p align=center>
   <a href="https://grafana.com/oss/grafana/">Grafana</a> with plugins installed into the image. Works without internet access.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
   <a href="https://github.com/dockette/grafana/actions"><img src="https://github.com/dockette/grafana/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/grafana"><img src="https://img.shields.io/docker/pulls/dockette/grafana.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

-----

## What it is

The upstream `grafana/grafana` image downloads plugins from grafana.com when it starts (`GF_PLUGINS_PREINSTALL`). On a network without internet access, the download fails and the panels that use the plugins break.

This image installs the plugins at build time. Each plugin has a pinned version.

| Plugin | Version |
|--------|---------|
| [marcusolsson-static-datasource](https://grafana.com/grafana/plugins/marcusolsson-static-datasource/) | 6.1.1 |
| [marcusolsson-treemap-panel](https://grafana.com/grafana/plugins/marcusolsson-treemap-panel/) | 2.1.1 |
| [victoriametrics-logs-datasource](https://grafana.com/grafana/plugins/victoriametrics-logs-datasource/) | 0.32.0 |

The image also sets:

- `GF_PATHS_PLUGINS=/opt/grafana/plugins` — the plugins stay available when you mount a volume on `/var/lib/grafana`.
- `GF_PLUGINS_PREINSTALL_DISABLED=true` — no plugin downloads at start.
- Update checks, usage reporting and the news feed are off.

## Usage

```sh
docker run -d --name grafana -p 3000:3000 dockette/grafana:13.2.3
```

Then open `http://localhost:3000` (`admin` / `admin`).

Do not set `GF_PATHS_PLUGINS` to a different path. If you do, Grafana does not find the plugins.

## Versions

| Image tag | Upstream |
|-----------|----------|
| `dockette/grafana:13.2.3` | `grafana/grafana:13.2.3` |
| `dockette/grafana:latest` | same as `13.2.3` |

## Development

```sh
make build        # build the image
make test         # list the installed plugins
make test-docker  # start the image without network, check that the plugins load
```

-----

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
