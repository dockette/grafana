<h1 align=center>Dockette / Grafana</h1>

<p align=center>
   <a href="https://grafana.com/oss/grafana/">Grafana</a> with plugins installed into the image.
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

The upstream `grafana/grafana` image downloads plugins from grafana.com when it starts (`GF_PLUGINS_PREINSTALL`). This
image installs them at build time. Each plugin has a pinned version.

## Features

- Grafana `13.2.3` on the upstream `grafana/grafana` image
- 22 plugins installed at build time, see the table below
- `GF_PATHS_PLUGINS=/opt/grafana/plugins`: the plugins stay available when you mount a volume on `/var/lib/grafana`
- `GF_PLUGINS_PREINSTALL_DISABLED=true`: no plugin downloads at start
- Update checks, usage reporting and the news feed are off

| Plugin | Version |
|--------|---------|
| [alexanderzobnin-zabbix-app](https://grafana.com/grafana/plugins/alexanderzobnin-zabbix-app/) | 6.9.1 |
| [briangann-datatable-panel](https://grafana.com/grafana/plugins/briangann-datatable-panel/) | 2.0.2 |
| [briangann-gauge-panel](https://grafana.com/grafana/plugins/briangann-gauge-panel/) | 2.2.0 |
| [camptocamp-prometheus-alertmanager-datasource](https://grafana.com/grafana/plugins/camptocamp-prometheus-alertmanager-datasource/) | 2.3.1 |
| [grafana-clickhouse-datasource](https://grafana.com/grafana/plugins/grafana-clickhouse-datasource/) | 4.22.1 |
| [grafana-clock-panel](https://grafana.com/grafana/plugins/grafana-clock-panel/) | 3.2.4 |
| [grafana-exploretraces-app](https://grafana.com/grafana/plugins/grafana-exploretraces-app/) | 2.2.1 |
| [grafana-lokiexplore-app](https://grafana.com/grafana/plugins/grafana-lokiexplore-app/) | 3.0.0 |
| [grafana-metricsdrilldown-app](https://grafana.com/grafana/plugins/grafana-metricsdrilldown-app/) | 3.0.0 |
| [grafana-polystat-panel](https://grafana.com/grafana/plugins/grafana-polystat-panel/) | 2.1.16 |
| [grafana-pyroscope-app](https://grafana.com/grafana/plugins/grafana-pyroscope-app/) | 2.3.1 |
| [jdbranham-diagram-panel](https://grafana.com/grafana/plugins/jdbranham-diagram-panel/) | 1.10.4 |
| [marcusolsson-csv-datasource](https://grafana.com/grafana/plugins/marcusolsson-csv-datasource/) | 1.0.3 |
| [marcusolsson-json-datasource](https://grafana.com/grafana/plugins/marcusolsson-json-datasource/) | 1.4.3 |
| [marcusolsson-static-datasource](https://grafana.com/grafana/plugins/marcusolsson-static-datasource/) | 6.1.1 |
| [marcusolsson-treemap-panel](https://grafana.com/grafana/plugins/marcusolsson-treemap-panel/) | 2.1.1 |
| [redis-datasource](https://grafana.com/grafana/plugins/redis-datasource/) | 2.2.0 |
| [simpod-json-datasource](https://grafana.com/grafana/plugins/simpod-json-datasource/) | 0.6.7 |
| [vertamedia-clickhouse-datasource](https://grafana.com/grafana/plugins/vertamedia-clickhouse-datasource/) | 3.5.0 |
| [victoriametrics-logs-datasource](https://grafana.com/grafana/plugins/victoriametrics-logs-datasource/) | 0.32.0 |
| [vonage-status-panel](https://grafana.com/grafana/plugins/vonage-status-panel/) | 2.0.4 |
| [yesoreyeram-infinity-datasource](https://grafana.com/grafana/plugins/yesoreyeram-infinity-datasource/) | 4.1.1 |

## Usage

```sh
docker run -d --name grafana -p 3000:3000 dockette/grafana:13.2.3

# Open http://localhost:3000 and log in as admin / admin
```

## Configuration

Do not set `GF_PATHS_PLUGINS` to a different path. If you do, Grafana does not find the plugins.

## Versions

| Version | Release |
|---------|---------|
| `dockette/grafana:13.2.3-YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/grafana:13.2.3` | latest release |
| `dockette/grafana:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/grafana:latest` | latest build of `master` |

All versions build on `grafana/grafana:13.2.3`. Releases are listed on [GitHub](https://github.com/dockette/grafana/releases).

## Development

```sh
make build          # build the image
make test           # list the installed plugins
make test-docker    # start the image, check that the plugins load
make run            # run Grafana on port 13000
make shell          # open a shell in the image
make push           # build and push linux/amd64 and linux/arm64
make version        # print VERSION
make release        # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
