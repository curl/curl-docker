build:
	docker build ${docker_build_options} ${docker_build_args} -t "curl/curl-alpine" -f Dockerfile .

lint:
	docker run --rm --privileged -v ${PWD}:/root/ projectatomic/dockerfile-lint dockerfile_lint -p -f Dockerfile

test:
	./test.sh

push-registry:
	#docker tag curl/curl-test
	#docker push

scan:
	curl -s https://ci-tools.anchore.io/inline_scan-v0.3.3 | bash -s -- -p -r curl/curl-alpine
	#docker build -t "curl/curl-scan-test" -f curl-scan .
	#docker run --privileged -d --name curl-scan -it curl/curl-scan-test
	#docker exec curl-scan sudo rkhunter --update || true
	#docker exec --privileged curl-scan sudo rkhunter -c -sk -q || true
	#docker exec curl-scan sudo cat /var/log/rkhunter/rkhunter.log > rkhunter9.log
	#docker exec --privileged curl-scan sudo lynis -c --quick --pentest --auditor "curl" audit system > lynis9.log
	#docker exec --privileged curl-scan sudo freshclam
	#docker exec --privileged curl-scan sudo clamscan -r / -i --exclude-dir=^/sys --exclude-dir=^/dev --exclude-dir=^/proc > clamscan9.log
	#docker kill curl-scan
	#docker rm curl-scan

clean:
	rm -Rf curl
	rm -Rf *.log
	rm -Rf anchore-reports
	rm -Rf scripts