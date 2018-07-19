test-node:
	docker run -i ${DOCKER_TAG} node --version || { echo "ERROR: node runtime is not available" && exit 1; }
