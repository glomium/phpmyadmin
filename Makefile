BASEIMAGE=ubuntu:rolling

build:
	docker build --build-arg BASEIMAGE=$(BASEIMAGE) -t phpmyadmin:local .
