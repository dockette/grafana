ARG GRAFANA_VERSION=13.2.3

FROM grafana/grafana:${GRAFANA_VERSION}

LABEL maintainer="sulcmil@gmail.com"

# PLUGINS ######################################################################
ENV GF_PATHS_PLUGINS=/opt/grafana/plugins
ENV GF_PLUGINS_PREINSTALL_DISABLED=true

ARG GRAFANA_PLUGINS="\
    alexanderzobnin-zabbix-app@6.9.1 \
    briangann-datatable-panel@2.0.2 \
    briangann-gauge-panel@2.2.0 \
    camptocamp-prometheus-alertmanager-datasource@2.3.1 \
    grafana-clickhouse-datasource@4.22.1 \
    grafana-clock-panel@3.2.4 \
    grafana-exploretraces-app@2.2.1 \
    grafana-lokiexplore-app@3.0.0 \
    grafana-metricsdrilldown-app@3.0.0 \
    grafana-polystat-panel@2.1.16 \
    grafana-pyroscope-app@2.3.1 \
    jdbranham-diagram-panel@1.10.4 \
    marcusolsson-csv-datasource@1.0.3 \
    marcusolsson-json-datasource@1.4.3 \
    marcusolsson-static-datasource@6.1.1 \
    marcusolsson-treemap-panel@2.1.1 \
    redis-datasource@2.2.0 \
    simpod-json-datasource@0.6.7 \
    vertamedia-clickhouse-datasource@3.5.0 \
    victoriametrics-logs-datasource@0.32.0 \
    vonage-status-panel@2.0.4 \
    yesoreyeram-infinity-datasource@4.1.1 \
"

USER root
RUN mkdir -p ${GF_PATHS_PLUGINS} && \
    for p in ${GRAFANA_PLUGINS}; do \
        grafana cli --pluginsDir ${GF_PATHS_PLUGINS} plugins install "${p%@*}" "${p#*@}" || exit 1; \
    done && \
    chown -R grafana:root ${GF_PATHS_PLUGINS}
USER grafana

# DEFAULTS #####################################################################
ENV GF_ANALYTICS_REPORTING_ENABLED=false
ENV GF_ANALYTICS_CHECK_FOR_UPDATES=false
ENV GF_ANALYTICS_CHECK_FOR_PLUGIN_UPDATES=false
ENV GF_NEWS_NEWS_FEED_ENABLED=false
