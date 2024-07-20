# Dart AST Explorer

by: @TheComputerM

## Running it locally

### Requirements

- NodeJS (+ pnpm preferably)
- Dart
- GNU make

### Steps

- Install dart packages using `dart pub get`.
- Build the WASM module using `make `.
- Install npm packages using `npm i` or `pnpm i` inside the *web* directory.
- Run `pnpm dev` inside the *web* directory and visit [https://localhost:5173/](https://localhost:5173/).