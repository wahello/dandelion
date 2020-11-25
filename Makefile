NAME=dandelion
VERSION=0.2.5
REGISTRY_PREFIX=$(if $(REGISTRY),$(addsuffix /, $(REGISTRY)))

.PHONY: build publish web

build:
	docker build --build-arg version=${VERSION} \
		--build-arg proxy=proxy.srv.maoer.cn:8123 \
		-t ${NAME}:${VERSION} .

publish:
	docker tag ${NAME}:${VERSION} ${REGISTRY_PREFIX}${NAME}:${VERSION}
	docker push ${REGISTRY_PREFIX}${NAME}:${VERSION}

web: web-dep
	cd web && npm run clean && npm run build
	cd .. && go generate ./...

web-dep:
	cd web && npm i
