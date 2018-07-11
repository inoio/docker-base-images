test-base:
	docker run -i ${DOCKER_TAG} /bin/true || { echo "ERROR: cannot call /bin/true" && exit 1; }
