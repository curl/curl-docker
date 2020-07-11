build:
	docker build ${DOCKER_BUILD_OPTS} ${DOCKER_BUILD_ARGS} -t "curl/curl:${LATEST_RELEASE_VERSION}" -f Dockerfile .

buildtest:
	docker build ${DOCKER_BUILD_OPTS} ${DOCKER_BUILD_ARGS} -t "curl/curl:scan-test" -f scanDockerfile .

multibuild:
	docker buildx build ${DOCKER_BUILD_OPTS} ${DOCKER_BUILD_ARGS} -t "curlimages/curl:7.71.1" --platform=${DOCKER_MULTI_ARCH} -f Dockerfile . --push
	docker buildx imagetools create docker.io/curlimages/curl:7.71.1 --tag curlimages/curl:latest

lint:
	docker run --rm --privileged -v ${PWD}:/root/ projectatomic/dockerfile-lint dockerfile_lint -p -f Dockerfile

test:
	../../bin/container-structure-test test --image curl/curl:${LATEST_RELEASE_VERSION} --config "test-container.yml"
	docker run --rm -it curl/curl:${LATEST_RELEASE_VERSION} -S http://httpbin.org/get

push-registry:
	docker tag curl/curl:${LATEST_RELEASE_VERSION} curlimages/curl:7.71.1
	docker push curlimages/curl:7.71.1
	docker tag curl/curl:${LATEST_RELEASE_VERSION} curlimages/curl:latest
	docker push curlimages/curl:latest

scan: buildtest
	docker run --rm -it curl/curl:scan-test rkhunter --update -c -sk || true
	docker run --rm -it curl/curl:scan-test clamscan -r -i --exclude-dir=^/sys || true
	docker run --rm -it curl/curl:scan-test lynis audit system
	docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/root/.cache/ aquasec/trivy curl/curl:${LATEST_RELEASE_VERSION}
	curl -s https://ci-tools.anchore.io/inline_scan-v0.6.1 | bash -s -- -p -r "curl/curl:${LATEST_RELEASE_VERSION}"

clean:
	rm -Rf curl
	rm -Rf *.log
	rm -Rf anchore-reports
