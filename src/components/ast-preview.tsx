import wasm_url from "~/lib/wasm/analyzer.wasm?url";
// @ts-ignore
import * as dart from "~/lib/wasm/analyzer.mjs";
import { computed } from "nanostores";
import { useStore } from "@nanostores/solid";
import { $inputCode } from "~/lib/store/input";
import { AstTreeNode, AstTreeBuilder } from "~/lib/analyzer/ast";
import { css } from "styled-system/css";

(globalThis as any).AstTreeNode = AstTreeNode;
(globalThis as any).AstTreeBuilder = AstTreeBuilder;

const bytes = await (await fetch(wasm_url)).arrayBuffer();
const module = await WebAssembly.compile(bytes);

const instance: WebAssembly.Instance = await dart.instantiate(module, {});

const $ast = computed($inputCode, (code) => {
  (globalThis as any).tree = new AstTreeBuilder();
  dart.invoke(instance, code);
  return (globalThis as any).tree.rootNode;
});

export const AstPreview = () => {
  const ast = useStore($ast);

  return (
    <textarea readOnly class={css({ width: "full", height: "calc(100% - 8px)" })}>
      {JSON.stringify(ast(), null, 2)}
    </textarea>
  );
};
