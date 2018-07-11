all: dockerfile build test


REGISTRY_amazon = xxxxxxxx.dkr.ecr.eu-central-1.amazonaws.com

.PHONY: build
build:
	docker build --build-arg RESOURCES=images/includes/resources -t ${DOCKER_TAG} -f ${IMAGE}/Dockerfile .

dockerfile: 
	# cross platform solution instead of using 'cpp'
	gcc -E -D"NAMESPACE=${NAMESPACE}" -x c -o  ${IMAGE}/Dockerfile ${IMAGE}/Dockerfile.in

include ${WD}/../*/test.mk

TEST_TARGETS=$(TESTS:%=test-%)

PUBLISH_TARGETS=$(REGISTRIES:%=publish-%)

# ruft alle Test-Targets auf. Diese müssen im Image-Makefile inkludiert werden.
test: $(TEST_TARGETS)

publish-%: prepare-%
	docker tag ${DOCKER_TAG} ${REGISTRY_${*}}/${DOCKER_TAG}
	docker push ${REGISTRY_${*}}/${DOCKER_TAG}
	docker tag ${DOCKER_TAG} ${REGISTRY_${*}}/${DOCKER_LATEST_TAG}
	docker push ${REGISTRY_${*}}/${DOCKER_LATEST_TAG}

publish: $(PUBLISH_TARGETS)

# amazon needs a login
prepare-amazon:
	`aws ecr get-login --no-include-email --region eu-central-1|sed 's/-e none//'`

# others don't need anything	
prepare-%: ;

.PHONY: clean
clean:
	rm -f ${WD}/Dockerfile
