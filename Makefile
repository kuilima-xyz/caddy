VERSION_BASE := $(shell sed -En 's|^.*github.com/caddyserver/caddy.*v(.*)|\1|p' go.mod)
VERSION_POSTFIX ?= kuilima1
VERSION := $(VERSION_BASE)+$(VERSION_POSTFIX)

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: no-dirty
no-dirty:
	@test -z "$(shell git status --porcelain)"

.PHONY: caddy_linux_amd64
caddy_linux_amd64:
	GOOS=linux GOARCH=amd64 go build -o $@ ./cmd/...

## build: build the application
.PHONY: build
build: caddy_linux_amd64

## release: create a release from the latest commit
.PHONY: release
release: no-dirty build
	git tag --annotate --message "Tag v$(VERSION)" v$(VERSION)
	git push --follow-tags
	gh release create --verify-tag v$(VERSION) caddy_linux_amd64
