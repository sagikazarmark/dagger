package buf

import (
	"dagger.io/dagger"

	"github.com/sagikazarmark/dagger/protobuf/buf"
)

dagger.#Plan & {
	client: filesystem: "./data": read: contents: dagger.#FS

	actions: test: buf.#Lint & {
		source: client.filesystem."./data".read.contents
	}
}
