all: build

build:
	docker build --rm -f Dockerfile -t alpine:cabin .

run:
	docker run --rm -it alpine:cabin
