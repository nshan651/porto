all: build run

build:
	podman build -f Dockerfile -t cabin .

run:
	podman run -it cabin

clean:
	podman rmi cabin
