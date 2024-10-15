import { json } from "@codemirror/lang-json";
import { Compartment, EditorState } from "@codemirror/state";
import { oneDark } from "@codemirror/theme-one-dark";
import { useStore } from "@tanstack/solid-store";
import { EditorView, basicSetup } from "codemirror";
import { createEffect, onMount } from "solid-js";
import { Box } from "styled-system/jsx";
import { store } from "~/lib/store";

const JSONView = () => {
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
				themeConfig.of([
					theme() === "light" ? editorLightTheme : editorDarkTheme,
				]),
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

	return <Box ref={jsonDisplayRef} />;
};

export default JSONView;
