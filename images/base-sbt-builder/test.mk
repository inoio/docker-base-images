test-sbt:
	docker run -i -e SBT_OPTS="-Xmx256M -Xms256M" ${DOCKER_TAG} -help > /dev/null || { echo "ERROR: sbt -help does not return successfully" && exit 1; }
