# Dart AST Explorer

by: @TheComputerM

## Running it locally

### Requirements

- NodeJS (+ pnpm preferably)
- Dart
- GNU make

### Steps

- Install npm packages using `npm i` or `pnpm i`.
- Install dart packages using `dart pub get`.
- Edit the Makefile and edit the *SDK_PATH* to dart2wasm's path on your local filesystem.
- Build the WASM module using `make wasm`.
- Run `pnpm dev` and visit [https://localhost:5173/](https://localhost:5173/).