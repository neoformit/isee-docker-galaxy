image_tag=latest
image_name=galaxy-isee-it
test_container_name=isee

internal_port=8888
port=-p 127.0.0.1:$(internal_port):$(internal_port)

docker_path=./docker
test_path="$(shell pwd)"/test-data/src

WEB_TAG=1.0.0
DOCKERHUB_NAME=neoformit
WEB_TARGET=$(DOCKERHUB_NAME)/$(image_name):$(WEB_TAG)
WEB_LATEST=$(DOCKERHUB_NAME)/$(image_name):latest

VPATH = docker:docker/scripts

build: Dockerfile run.sh monitor_traffic.sh
	echo "Building container ${image_name}:${image_tag}"
	@docker build --no-cache \
		--build-arg PORT=${internal_port} \
		-t $(image_name):$(image_tag) $(docker_path)
	@docker tag $(image_name) $(WEB_TARGET)
	@docker tag $(image_name) $(WEB_LATEST)

deploy: build
	docker push $(WEB_LATEST)

test:
	echo "Running test iSEE"
	docker run $(port) \
		-v $(test_path):/import \
		--name $(test_container_name) $(image_name):$(image_tag) \
		/scripts/run.sh \
		/import/isee.R
	docker container prune

stop:
	docker kill `docker ps | grep -Poe '[a-z0-9]{12}'` || true
	docker container prune

clean: stop
	docker rmi $(image_name) || true

.PHONY: build stop
