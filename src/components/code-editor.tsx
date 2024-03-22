import { createCodeMirror } from "solid-codemirror"

export const CodeEditor = () => {
  const { ref: editorRef } = createCodeMirror({
    value: "console.log('a')",
  });
  return <div ref={editorRef} />
}