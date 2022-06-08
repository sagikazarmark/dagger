package markdownlint

import (
	"dagger.io/dagger"

	"github.com/sagikazarmark/dagger/markdown/markdownlint"
)

dagger.#Plan & {
	client: filesystem: "./data": read: contents: dagger.#FS

	actions: test: markdownlint.#Lint & {
		source: client.filesystem."./data".read.contents
		files: ["README.md", "docs/"]
	}
}
