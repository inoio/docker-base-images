test-jre:
	docker run -i ${DOCKER_TAG} java -version || { echo "ERROR: java runtime is not available" && exit 1; }
