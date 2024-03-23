// @ts-nocheck
import * as dart from "~/lib/wasm/ast.mjs";
import wasm_url from "~/lib/wasm/ast.wasm?url";
import { createSignal, onMount } from "solid-js";

class AstTreeNode {
  readonly id: int;
  readonly type: string;
  readonly source: string;
  readonly range: [int, int];
  readonly children: AstTreeNode[];

  constructor(id: int, type: string, source: string, start: int, end: int,) {
    this.id = id;
    this.type = type;
    this.source = source;
    this.range = [start, end];
    this.children = [];
  }

  findChild(id: int) {
    return this.children.find((node) => node.id === id);
  }
}

class AstTreeBuilder {
  readonly rootNode: AstTreeNode;
  readonly _currentAddress: int[];

  constructor() {
    this.rootNode = new AstTreeNode(0, 'ROOT');
    this._currentAddress = [];
  }

  visitNode(node: AstTreeNode) {
    const parentNode = this._getCurrentTreeNode();
    parentNode.children.push(node);
    this._currentAddress.push(node.id);
  }

  popNode() {
    this._currentAddress.pop();
  }

  _getCurrentTreeNode() {
    let currentNode = this.rootNode;
    for (const id of this._currentAddress) {
      currentNode = currentNode.findChild(id);
    }
    return currentNode;
  }
}

globalThis.AstTreeNode = AstTreeNode;
globalThis.AstTreeBuilder = AstTreeBuilder;
globalThis.tree = new AstTreeBuilder();

export const AstPreview = () => {
  const [ast, setAst] = createSignal("Nothing");

  onMount(async () => {
    const bytes = await (await fetch(wasm_url)).arrayBuffer();
    const module = await WebAssembly.compile(bytes);

    const instance: WebAssembly.Instance = await dart.instantiate(module, {});

    dart.invoke(instance, `void main() {
  print('Hello');
}
    `);
    setAst(JSON.stringify(globalThis.tree.rootNode, null, 2));
  });
  return <pre>{ast()}</pre>;
};
