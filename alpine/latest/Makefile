build:
	docker build ${DOCKER_BUILD_OPTS} ${DOCKER_BUILD_ARGS} -t "curl/curl:${LATEST_RELEASE_VERSION}" -f Dockerfile .

multibuild:
	docker buildx build ${DOCKER_BUILD_OPTS} ${DOCKER_BUILD_ARGS} -t "curlimages/curl:7.84.0" --platform=${DOCKER_MULTI_ARCH} -f Dockerfile . --push
	docker buildx imagetools create docker.io/curlimages/curl:7.84.0 --tag curlimages/curl:latest

lint:
	docker run --rm --privileged -v ${PWD}:/root/ projectatomic/dockerfile-lint dockerfile_lint -p -f Dockerfile

test:
	../../bin/container-structure-test test --image curl/curl:${LATEST_RELEASE_VERSION} --config "test-container.yml"
	docker run --rm curl/curl:${LATEST_RELEASE_VERSION} -S http://httpbin.org/get

push-registry:
	docker tag curl/curl:${LATEST_RELEASE_VERSION} curlimages/curl:7.84.0
	docker push curlimages/curl:7.84.0
	docker tag curl/curl:${LATEST_RELEASE_VERSION} curlimages/curl:latest
	docker push curlimages/curl:latest

scan:
	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/root/.cache/ aquasec/trivy curl/curl:${LATEST_RELEASE_VERSION}
	curl -sSfL https://raw.githubusercontent.com/anchore/grype/main/install.sh | sh -s -- -b /usr/local/bin && grype curl/curl:${LATEST_RELEASE_VERSION}

clean:
	rm -Rf curl
	rm -Rf *.log
	rm -Rf anchore-reports
