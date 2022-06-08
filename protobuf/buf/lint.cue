package buf

import (
	"dagger.io/dagger"

	"universe.dagger.io/docker"
)

// Lint using protobuf files using buf
#Lint: {
	// Source code
	source: dagger.#FS

	// buf version
	version: *"1.5.0" | string

	_image: docker.#Pull & {
		source: "index.docker.io/bufbuild/buf:\(version)"
	}

	_sourcePath: "/src"

	docker.#Run & {
		input: *_image.output | docker.#Image
		entrypoint: []
		command: {
			name: "buf"
			args: ["lint"]
			flags: {
				"-v": true
			}
		}
		workdir: _sourcePath
		mounts: "source": {
			contents: source
			dest:     _sourcePath
		}
	}
}
