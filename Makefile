PROJECT := progressive-weather-app
# we use first 6 character from commit id as VERSION for tagging the docker image
VERSION := $(shell git rev-parse --short=6 HEAD)
DOCKER_IMAGE := $(PROJECT):$(VERSION)

.PHONY: test build push deploy

test:
	docker build -t $(PROJECT)-test --target=testrunner . && \
	docker run --rm $(PROJECT)-test

build:
	docker build -t $(DOCKER_IMAGE) .

push:
	docker push gilankpam/$(DOCKER_IMAGE)

deploy:
	helm upgrade $(PROJECT) ./deploy/chart \
		--install --wait \
		--set image.repository=gilankpam/$(PROJECT) \
		--set image.tag=$(VERSION)