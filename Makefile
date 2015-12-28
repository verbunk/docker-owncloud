
NAME=owncloud
PWD=$(shell pwd)
VERSION=8.2.2

build:
	docker build -t ${NAME} .

shell: build
	docker run -it --rm ${NAME} sh

test: build
	docker run --link mysql:mysql --rm -it -P -v ${PWD}/volumes/data:/usr/share/owncloud/data -v ${PWD}/volumes/config:/usr/share/owncloud/config ${NAME}

daemon: build
	docker run -d --name ${NAME} ${NAME}

release:
	git commit -av -e -m "Upgrade to owncloud ${VERSION}" && \
	git tag -f ${VERSION} && \
	git push && \
	git push --tags -f
