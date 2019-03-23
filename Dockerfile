FROM node:alpine AS dev

RUN apk add --update git \
  && rm -rf /var/cache/apk/*

WORKDIR /
RUN git clone https://github.com/kannkyo/grafana-3d-globe-panel.git

WORKDIR /grafana-3d-globe-panel
RUN git checkout -b cesium-1.55 origin/cesium-1.55
RUN npm install && npm run build

FROM grafana/grafana:6.0.2 AS application

COPY --from=dev --chown=grafana:grafana /grafana-3d-globe-panel /var/lib/grafana/plugins/grafana-3d-globe-panel
