package markdownlint

import (
	"dagger.io/dagger"

	"universe.dagger.io/docker"
)

// Lint markdown files using markdownlint
#Lint: {
	// Source code
	source: dagger.#FS

	// markdownlint version
	version: *"0.31.1" | string

	// Files to lint
	files: [...string]

	_image: docker.#Pull & {
		source: "tmknom/markdownlint:\(version)"
	}

	_sourcePath: "/src"

	docker.#Run & {
		input: *_image.output | docker.#Image
		command: {
			name: "markdownlint"
			args: files
		}
		workdir: _sourcePath
		mounts: "source": {
			contents: source
			dest:     _sourcePath
		}
	}
}
