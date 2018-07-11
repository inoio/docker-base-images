test-service:
	docker run -i ${DOCKER_TAG} [[ -x /usr/bin/execlineb ]] || { echo "ERROR: s6 is not available" && exit 1; }
