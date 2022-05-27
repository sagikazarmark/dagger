package golangci

import (
	"dagger.io/dagger"

	"github.com/sagikazarmark/dagger/go/golangci"
)

dagger.#Plan & {
	client: filesystem: "./data/hello": read: contents: dagger.#FS

	actions: test: golangci.#Lint & {
		source: client.filesystem."./data/hello".read.contents
	}
}
