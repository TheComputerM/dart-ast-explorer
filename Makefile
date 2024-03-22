SDK_PATH := ../dart-sdk/sdk/pkg/dart2wasm/bin/dart2wasm.dart

.PHONY: wasm
wasm:
	dart --enable-asserts $(SDK_PATH) ./src/lib/analyzer/main.dart ./src/lib/wasm/ast.wasm