all: build run

## For docker image/container management
build:
	docker build --platform linux/amd64 -t tbmpr .

run:
	docker run --platform linux/amd64 -it --rm -v $(PWD):/src tbmpr

prune:
	docker container prune -f

delete:
	docker rmi -f tbmpr

## For running gpu-enabled docker container on linux
linux:
	docker run --runtime=nvidia --gpus all --platform linux/amd64 -it --rm -v $(shell pwd)/:/src tbmpr
