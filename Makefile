all: build run

build:
	podman build -f Dockerfile -t porto .

run:
	podman run -it porto

clean:
	podman rmi porto
