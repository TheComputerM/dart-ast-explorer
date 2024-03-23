// @ts-ignore
import * as dart from "~/lib/wasm/ast.mjs";
import wasm_url from "~/lib/wasm/ast.wasm?url";
import { computed } from "nanostores";
import { useStore } from "@nanostores/solid";
import { $inputCode } from "~/lib/store/input";
import { AstTreeNode, AstTreeBuilder } from "~/lib/analyzer/ast";
import { css } from "styled-system/css";

// @ts-ignore
globalThis.AstTreeNode = AstTreeNode;
// @ts-ignore
globalThis.AstTreeBuilder = AstTreeBuilder;

const bytes = await (await fetch(wasm_url)).arrayBuffer();
const module = await WebAssembly.compile(bytes);

const instance: WebAssembly.Instance = await dart.instantiate(module, {});

const $ast = computed($inputCode, (code) => {
  // @ts-ignore
  globalThis.tree = new AstTreeBuilder();
  dart.invoke(instance, code);
  // @ts-ignore
  return globalThis.tree.rootNode;
});

export const AstPreview = () => {
  const ast = useStore($ast);

  return (
    <textarea class={css({ flexBasis: "1/2", height: "full" })}>
      {JSON.stringify(ast(), null, 2)}
    </textarea>
  );
};
