.PHONY: docker

docker: Dockerfile
	sudo docker image build -t bazel .

run: docker
	sudo docker container run --rm -it -v `pwd`:/root/work bazel bash


