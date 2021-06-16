#!/usr/bin/env bash
set -euo pipefail

# deduce latest release from github
echo "get curl latest release source"
release_tag_redirect=`curl -fsS https://github.com/curl/curl/releases/latest -w'%{redirect_url}\n' -o /dev/null`
export latest_release_tag=`basename ${release_tag_redirect}`
latest_release_tarball="https://github.com/curl/curl/archive/${latest_release_tag}.tar.gz"
echo $latest_release_tarball
curl -fsSL -o curl.tar.gz $latest_release_tarball && mkdir curl && tar -xf curl.tar.gz -C curl --strip-components=1

# download container-structure-test tool
echo "get container-structure-test tool for tests"
if [[ "$OSTYPE" == "darwin"* ]]; then
curl -fsSLO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-darwin-amd64 && chmod +x container-structure-test-darwin-amd64 && mkdir -p bin && mv container-structure-test-darwin-amd64 bin/container-structure-test
else
echo "install container structure test, requires sudo"
curl -fsSLO https://storage.googleapis.com/container-structure-test/latest/container-structure-test-linux-amd64 && chmod +x container-structure-test-linux-amd64 && mkdir -p bin && mv container-structure-test-linux-amd64 bin/container-structure-test
fi
