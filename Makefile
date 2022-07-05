tag_prefix := artw/rdp

UBUNTU_VERSIONS = 18.04 20.04 22.04 22.10

SHELL := bash
.PHONY: all
all: build push

.PHONY: build
build:
	for v in $(UBUNTU_VERSIONS); do \
		docker build -t ${tag_prefix}:$${v} --build-arg UBUNTU_VERSION=$${v} .; \
	done; \
  docker build -t ${tag_prefix}:latest .

.PHONY: push
push:
	for v in $(UBUNTU_VERSIONS); do \
		docker push ${tag_prefix}:$${v}; \
	done; \
  docker push ${tag_prefix}:latest
