.PHONY: build
build:
	dart compile wasm ./lib/main.dart -o ./web/src/lib/analyzer/ast-analyzer.wasm

.PHONY: walker
walker:
	dart run tool/gen_walker.dart