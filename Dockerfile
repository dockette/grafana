ARG GRAFANA_VERSION=13.2.3

FROM grafana/grafana:${GRAFANA_VERSION}

LABEL maintainer="sulcmil@gmail.com"

# PLUGINS ######################################################################
ENV GF_PATHS_PLUGINS=/opt/grafana/plugins
ENV GF_PLUGINS_PREINSTALL_DISABLED=true

USER root
RUN mkdir -p ${GF_PATHS_PLUGINS} && \
    grafana cli --pluginsDir ${GF_PATHS_PLUGINS} plugins install marcusolsson-static-datasource 6.1.1 && \
    grafana cli --pluginsDir ${GF_PATHS_PLUGINS} plugins install marcusolsson-treemap-panel 2.1.1 && \
    grafana cli --pluginsDir ${GF_PATHS_PLUGINS} plugins install victoriametrics-logs-datasource 0.32.0 && \
    chown -R grafana:root ${GF_PATHS_PLUGINS}
USER grafana

# OFFLINE ######################################################################
ENV GF_ANALYTICS_REPORTING_ENABLED=false
ENV GF_ANALYTICS_CHECK_FOR_UPDATES=false
ENV GF_ANALYTICS_CHECK_FOR_PLUGIN_UPDATES=false
ENV GF_NEWS_NEWS_FEED_ENABLED=false
