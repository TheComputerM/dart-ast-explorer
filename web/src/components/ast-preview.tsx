import wasm_url from "tool/ast-analyzer.wasm?url";
// @ts-ignore
import * as dart from "tool/ast-analyzer.mjs";
import { computed } from "nanostores";
import { useStore } from "@nanostores/solid";
import { $inputCode } from "~/lib/store/input";
import { AstTreeNode, AstTreeBuilder } from "~/lib/analyzer/ast";
import { createEffect, onMount } from "solid-js";
import { EditorView, basicSetup } from "codemirror";
import { Compartment, EditorState } from "@codemirror/state";
import { json } from "@codemirror/lang-json";
import { Box } from "styled-system/jsx";
import { dracula, tomorrow } from "thememirror";
import { Tabs } from "~/components/ui";
import { $theme } from "~/lib/store/theme";

(globalThis as any).AstTreeNode = AstTreeNode;
(globalThis as any).AstTreeBuilder = AstTreeBuilder;

const bytes = await (await fetch(wasm_url)).arrayBuffer();
const module = await WebAssembly.compile(bytes);

const instance: WebAssembly.Instance = await dart.instantiate(module, {});

const $ast = computed($inputCode, (code) => {
  (globalThis as any).tree = new AstTreeBuilder();
  dart.invoke(instance, code);
  return (globalThis as any).tree.rootNode as { children: AstTreeNode[] };
});

const AstPreview = () => {
  const ast = useStore($ast);
  const theme = useStore($theme);

  let jsonDisplayRef;
  let editor: EditorView;

  const themeConfig = new Compartment();
  onMount(() => {
    editor = new EditorView({
      doc: JSON.stringify(ast().children, null, 2),

      extensions: [
        basicSetup,
        json(),
        themeConfig.of([tomorrow]),
        EditorView.theme({
          "&": {
            height: "100%",
          },
        }),
        EditorState.readOnly.of(true),
      ],
      parent: jsonDisplayRef!,
    });

    return () => {
      editor.destroy();
    };
  });

  createEffect(() => {
    if (editor) {
      editor.update([
        editor.state.update({
          changes: {
            from: 0,
            to: editor.state.doc.length,
            insert: JSON.stringify(ast().children, null, 2),
          },
        }),
      ]);
    }
  });

  createEffect(() => {
    if (editor) {
      editor.dispatch({
        effects: themeConfig.reconfigure([
          theme() === "light" ? tomorrow : dracula,
        ]),
      });
    }
  });

  return (
    <Box flexGrow={1} height="full" overflow="auto">
      <Tabs.Root size="sm" value="tree" variant="line">
        <Tabs.List>
          <Tabs.Trigger value="tree" alignItems="end">
            Tree
          </Tabs.Trigger>
          <Tabs.Trigger value="json" alignItems="end">
            JSON
          </Tabs.Trigger>
          <Tabs.Indicator />
        </Tabs.List>
        <Tabs.Content value="tree" pt="0">
          TODO
        </Tabs.Content>
        <Tabs.Content value="json" pt="0">
          <Box
            height="full"
            flexGrow={1}
            overflow="auto"
            ref={jsonDisplayRef}
          />
        </Tabs.Content>
      </Tabs.Root>
    </Box>
  );
};

export default AstPreview;
