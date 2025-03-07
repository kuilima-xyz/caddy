VERSION_BASE := $(shell sed -En 's|^.*github.com/caddyserver/caddy.*v(.*)|\1|p' go.mod)
VERSION_POSTFIX ?= kuilima1
VERSION := $(VERSION_BASE)+$(VERSION_POSTFIX)

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## release: create a release from the latest commit
.PHONY: release
release:
	gh run download -n caddy_linux_amd64
	mv caddy caddy_linux_amd64
	git tag --annotate --message "Tag v$(VERSION)"
	git push --follow-tags
	gh release create v$(VERSION)
	gh release upload caddy_linux_amd64
