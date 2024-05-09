import { defineConfig } from "vite";
import solid from "vite-plugin-solid";
import tsconfigPaths from "vite-tsconfig-paths";

export default defineConfig({
  plugins: [tsconfigPaths({ root: "./" }), solid()],
  base: "/dart-ast-explorer/",
  build: {
    target: 'esnext'
  }
});
