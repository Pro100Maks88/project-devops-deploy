test:
	./gradlew test

start: run

run:
	./gradlew bootRun

update-gradle:
	./gradlew wrapper --gradle-version 9.2.1

update-deps:
	./gradlew versionCatalogUpdate

install:
	./gradlew dependencies

build:
	./gradlew build

lint:
	./gradlew spotlessCheck

lint-fix:
	./gradlew spotlessApply

.PHONY: build

IMAGE = golovinmd/project-devops-deploy
TAG = latest

.PHONY: docker-build docker-run docker-push

docker-build:
	docker build -t $(IMAGE):$(TAG) .
	docker tag $(IMAGE):$(TAG) $(IMAGE):v0.1.0

docker-run:
	docker run --rm -p 8080:8080 -p 9090:9090 $(IMAGE):$(TAG)

docker-push:
	docker push $(IMAGE):$(TAG)
	docker push $(IMAGE):v0.1.0
