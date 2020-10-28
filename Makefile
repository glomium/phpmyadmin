UBUNTU=rolling

build:
	docker build --build-arg UBUNTU=$(UBUNTU) -t phpmyadmin:local .

buildx:
	docker buildx build --progress plain --platform linux/amd64,linux/arm64,linux/arm/v7 --build-arg UBUNTU=$(UBUNTU) --push -t glomium/phpmyadmin:multiarch .
