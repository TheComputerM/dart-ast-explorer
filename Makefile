.PHONY: build
build:
	dart compile wasm ./lib/main.dart -o ./web/bin/ast-analyzer.wasm