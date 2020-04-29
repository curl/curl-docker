build:
	docker build ${DOCKER_BUILD_OPTS} ${DOCKER_BUILD_ARGS} -t "curlimages/curl:${LATEST_RELEASE_VERSION}" -f Dockerfile .

multibuild:
	docker buildx build ${DOCKER_BUILD_OPTS} ${DOCKER_BUILD_ARGS} -t "curlimages/curl:test_${LATEST_RELEASE_VERSION}" --platform=${DOCKER_MULTI_ARCH} -f Dockerfile . --push

lint:
	docker run --rm --privileged -v ${PWD}:/root/ projectatomic/dockerfile-lint dockerfile_lint -p -f Dockerfile

test:
	../../bin/container-structure-test test --image curl/curl:${LATEST_RELEASE_VERSION} --config "test-container.yml"
	docker run --rm -it curl/curl:${LATEST_RELEASE_VERSION} -S http://httpbin.org/get

push-registry:
	docker tag curl/curl:${LATEST_RELEASE_VERSION} curlimages/curl:7.70.0
	docker push curlimages/curl:7.70.0
	docker tag curl/curl:${LATEST_RELEASE_VERSION} curlimages/curl:latest
	docker push curlimages/curl:latest

scan:
	curl -s https://ci-tools.anchore.io/inline_scan-v0.6.1 | bash -s -- -p -r "curl/curl:${LATEST_RELEASE_VERSION}"

clean:
	rm -Rf curl
	rm -Rf *.log
	rm -Rf anchore-reports
