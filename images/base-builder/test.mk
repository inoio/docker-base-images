test-builder:
	docker run -i ${DOCKER_TAG} docker -v || { echo "ERROR: docker command not available" && exit 1; }
