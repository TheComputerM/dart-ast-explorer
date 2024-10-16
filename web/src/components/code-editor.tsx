import { basicSetup, EditorView } from "codemirror";
import { StreamLanguage } from "@codemirror/language";
import { dart } from "@codemirror/legacy-modes/mode/clike";
import { createEffect, onMount } from "solid-js";
import { debounce } from "@solid-primitives/scheduled";
import { Box } from "styled-system/jsx";
import { Compartment } from "@codemirror/state";
import { useStore } from "@tanstack/solid-store";
import { store } from "~/lib/store";
import { oneDark } from "@codemirror/theme-one-dark";

export const CodeEditor = () => {
	const code = useStore(store, (state) => state.code);
	const theme = useStore(store, (state) => state.theme);
	const updateCode = debounce(
		(input: string) => store.setState((state) => ({ ...state, code: input })),
		750,
	);

	const editorLightTheme = EditorView.baseTheme({});
	const editorDarkTheme = oneDark;

	let editorRef;
	let editor: EditorView;
	const themeConfig = new Compartment();
	onMount(() => {
		editor = new EditorView({
			doc: code(),
			extensions: [
				basicSetup,
				StreamLanguage.define(dart),
				EditorView.updateListener.of((viewUpdate) => {
					if (viewUpdate.docChanged) {
						updateCode(viewUpdate.view.state.doc.toString());
					}
				}),
				themeConfig.of([
					theme() === "light" ? editorLightTheme : editorDarkTheme,
				]),
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

	createEffect(() => {
		if (editor) {
			editor.dispatch({
				effects: themeConfig.reconfigure([
					theme() === "light" ? editorLightTheme : editorDarkTheme,
				]),
			});
		}
	});

	return <Box height="full" flexGrow={1} ref={editorRef} />;
};
