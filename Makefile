PROJECT_NAME := "yottad-bind"
DNSSERVER := $(shell uname -n)
PWD := $(shell pwd)

.PHONY: build run test clean

all: build run test clean

build: ## Build container from Dockerfile
	@podman build -t $(PROJECT_NAME) -f Dockerfile . 

run: ## Run $(PROJECT_NAME) container
	@podman run --rm --name $(PROJECT_NAME) -td  -v $(PWD)/conf:/opt/named -p 53:53/tcp -p 53:53/udp bind 

restart: ## Restart container
	@podman restart $(PROJECT_NAME) 

test: ## Run nslookup on foobar.yotta.local
	@nslookup foo.yotta.local $(DNSSERVER)

clean: ## Remove previous build
	@podman stop  $(PROJECT_NAME)

help: ## Display this help screen
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
