import wasm_url from "~/lib/analyzer/ast-analyzer.wasm?url";
// @ts-ignore
import * as dart from "~/lib/analyzer/ast-analyzer.mjs";
import { createEffect, onMount } from "solid-js";
import { EditorView, basicSetup } from "codemirror";
import { Compartment, EditorState } from "@codemirror/state";
import { json } from "@codemirror/lang-json";
import { Box } from "styled-system/jsx";
import { Tabs } from "~/components/ui/tabs";
import { useStore } from "@tanstack/solid-store";
import { store } from "~/lib/store";
import { oneDark } from "@codemirror/theme-one-dark";

const bytes = await (await fetch(wasm_url)).arrayBuffer();
const module = await WebAssembly.compile(bytes);

const instance: WebAssembly.Instance = await dart.instantiate(module, {});

const JSONPreview = () => {
  const theme = useStore(store, (state) => state.theme);
  const ast = useStore(store, (state) => state.ast);

  const editorLightTheme = EditorView.baseTheme({});
  const editorDarkTheme = oneDark;

  let jsonDisplayRef;
  let editor: EditorView;
  const themeConfig = new Compartment();

  onMount(() => {
    editor = new EditorView({
      doc: JSON.stringify(ast(), null, 2),

      extensions: [
        basicSetup,
        json(),
        themeConfig.of([theme() === "light" ? editorLightTheme : editorDarkTheme]),
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
            insert: JSON.stringify(ast(), null, 2),
          },
        }),
      ]);
    }
  });

  createEffect(() => {
    if (editor) {
      editor.dispatch({
        effects: themeConfig.reconfigure([
          theme() === "light" ? editorLightTheme : editorDarkTheme,
        ]),
      });
    }
  });

  return <Box ref={jsonDisplayRef} />
}

const AstPreview = () => {
  const code = useStore(store, (state) => state.code);

  createEffect(() => {
    dart.invoke(instance, code());
  });

  return (
    <Tabs.Root flexGrow={1} height="full" overflow="auto" size="sm" variant="enclosed" defaultValue="json">
      <Tabs.List position="sticky" top="0" zIndex="docked">
        <Tabs.Trigger value="tree">
          Tree
        </Tabs.Trigger>
        <Tabs.Trigger value="json">
          JSON
        </Tabs.Trigger>
        <Tabs.Indicator />
      </Tabs.List>
      <Tabs.Content value="tree" p="0">
        TODO
      </Tabs.Content>
      <Tabs.Content value="json" p="0">
        <JSONPreview />
      </Tabs.Content>
    </Tabs.Root>
  );
};

export default AstPreview;
