import { useStore } from "@nanostores/solid";
import { $inputCode } from "~/lib/store/input";
import { basicSetup, EditorView } from "codemirror";
import { StreamLanguage } from "@codemirror/language";
import { dart } from "@codemirror/legacy-modes/mode/clike";
import { onMount } from "solid-js";
import { debounce } from "@solid-primitives/scheduled";
import { css } from "styled-system/css";

export const CodeEditor = () => {
  const code = useStore($inputCode);
  const updateCode = debounce((input: string) => $inputCode.set(input), 500);

  let editorRef;
  onMount(() => {
    const editor = new EditorView({
      doc: code(),
      extensions: [
        basicSetup,
        StreamLanguage.define(dart),
        EditorView.updateListener.of((v) => {
          if (v.docChanged) {
            updateCode(v.view.state.doc.toString());
          }
        }),
        EditorView.theme({
          "&": {
            height: "100%",
          },
        }),
      ],
      parent: editorRef!,
    });

    return () => {
      editor.destroy();
    };
  });

  return <div class={css({ height: "full" })} ref={editorRef} />;
};
