CONTAINER_IMAGE ?= cagedata/gcloud
CONTAINER_TAG ?= latest

all: build push

build:
	@docker build --pull --tag ${CONTAINER_IMAGE} .
	@docker tag ${CONTAINER_IMAGE} ${CONTAINER_IMAGE}:${CONTAINER_TAG}

push:
	@docker push ${CONTAINER_IMAGE}
	@docker push ${CONTAINER_IMAGE}:${CONTAINER_TAG}
