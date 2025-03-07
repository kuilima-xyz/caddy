# caddy for kuilima.xyz

A specialized build of [caddy](https://github.com/caddyserver/caddy) for [kuilima.xyz](https://github.com/kuilima-xyz).

## Release

Upgrade to the latest version of caddy and any additional modules.

```bash
go get github.com/caddy-dns/namecheap@latest
go get github.com/caddyserver/caddy/v2@latest
```

Commit and push those changes. Then, you can create a release.

```bash
make release
```

If you need to bump the version again, you can set the `VERSION_PREFIX` environment variable.

```bash
VERSION_PREFIX=kuilima2 make release
```
