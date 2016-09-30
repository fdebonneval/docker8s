VERSION    ?= 1.4.0
REPOSITORY ?= hypercube
IMAGE      ?= $(REPOSITORY):$(VERSION)

BUILD_OPTIONS = -t $(IMAGE)
ifdef http_proxy
BUILD_OPTIONS += --build-arg http_proxy=$(http_proxy)
endif
ifdef https_proxy
BUILD_OPTIONS += --build-arg https_proxy=$(https_proxy)
endif
BUILD_OPTIONS += --build-arg application_version=$(VERSION)

RUN_OPTIONS = -v /var/run/docker.sock:/var/run/docker.sock
RUN_OPTIONS += -v /var/run/docker.pid:/var/run/docker.pid:ro
RUN_OPTIONS += -v /var/run/docker:/var/run/docker:ro
RUN_OPTIONS += -v /usr/bin/docker:/usr/bin/docker:ro
RUN_OPTIONS += --privileged
RUN_OPTIONS += -p 10250:10250

default: run

build:
	docker build $(BUILD_OPTIONS) .

alias:
	source .aliases
run:
	docker network ls | grep k8s_service || \
	  docker network create --subnet=10.0.0.0/16 k8s_service
	K8S_IMAGE=$(IMAGE) docker-compose -f kubernetes.yml up

clean:
	docker-compose -f kubernetes.yml rm
	docker network rm k8s_service
