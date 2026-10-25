DOCKER_IMAGE=dockette/grafana
DOCKER_TAG?=${GRAFANA_VERSION}
DOCKER_PLATFORMS?=linux/amd64,linux/arm64
include VERSION

GRAFANA_PORT?=13000

.PHONY: build
build:
	docker build \
		--build-arg GRAFANA_VERSION=${GRAFANA_VERSION} \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		.

.PHONY: push
push:
	docker buildx build \
		--platform ${DOCKER_PLATFORMS} \
		--build-arg GRAFANA_VERSION=${GRAFANA_VERSION} \
		-t ${DOCKER_IMAGE}:${DOCKER_TAG} \
		--push \
		.

.PHONY: run
run:
	docker run --rm -it -p ${GRAFANA_PORT}:3000 ${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: shell
shell:
	docker run --rm -it --entrypoint /bin/sh ${DOCKER_IMAGE}:${DOCKER_TAG}

.PHONY: test
test:
	docker run --rm --entrypoint grafana ${DOCKER_IMAGE}:${DOCKER_TAG} cli --pluginsDir /opt/grafana/plugins plugins ls

# Start the image and check that every plugin loads
.PHONY: test-docker
test-docker:
	IMAGE=${DOCKER_IMAGE}:${DOCKER_TAG} ./tests/smoke.sh

.PHONY: version
version:
	@echo ${VERSION}

.PHONY: release
release:
	@sed -i.bak "s/^VERSION=.*/VERSION=$$(date -u +%Y.%m.%d)/" VERSION && rm VERSION.bak
	@cat VERSION
