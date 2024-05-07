.PHONY: wasm
wasm:
	dart compile wasm ./src/lib/analyzer/main.dart -o ./src/lib/wasm/analyzer.wasm