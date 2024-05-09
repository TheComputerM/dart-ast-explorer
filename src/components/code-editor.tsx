import { useStore } from "@nanostores/solid";
import { $inputCode } from "~/lib/store/input";
import { basicSetup, EditorView } from "codemirror";
import { StreamLanguage } from "@codemirror/language";
import { dart } from "@codemirror/legacy-modes/mode/clike";
import { onMount } from "solid-js";
import { debounce } from "@solid-primitives/scheduled";
import { Box } from "styled-system/jsx";
import { tomorrow } from 'thememirror';

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
        EditorView.updateListener.of((viewUpdate) => {
          if (viewUpdate.docChanged) {
            updateCode(viewUpdate.view.state.doc.toString());
          }
        }),
        tomorrow,
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

  return <Box height="full" flexGrow={1} ref={editorRef} />;
};
