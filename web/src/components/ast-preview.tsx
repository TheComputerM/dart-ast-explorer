import wasm_url from "~/lib/analyzer/ast-analyzer.wasm?url";
import { useStore } from "@tanstack/solid-store";
import { createEffect } from "solid-js";
import { Tabs } from "~/components/ui/tabs";
// @ts-ignore
import * as dart from "~/lib/analyzer/ast-analyzer.mjs";
import { store } from "~/lib/store";
import JSONView from "./json-view";
import TreeView from "./tree-view";

const bytes = await (await fetch(wasm_url)).arrayBuffer();
const module = await WebAssembly.compile(bytes);

const instance: WebAssembly.Instance = await dart.instantiate(module, {});

const AstPreview = () => {
	const code = useStore(store, (state) => state.code);

	createEffect(() => {
		dart.invoke(instance, code());
	});

	return (
		<Tabs.Root
			flexGrow={1}
			height="full"
			overflow="auto"
			size="sm"
			variant="enclosed"
			defaultValue="json"
		>
			<Tabs.List position="sticky" top="0" zIndex="docked">
				<Tabs.Trigger value="tree">Tree</Tabs.Trigger>
				<Tabs.Trigger value="json">JSON</Tabs.Trigger>
				<Tabs.Indicator />
			</Tabs.List>
			<Tabs.Content value="tree" p="0">
				<TreeView />
			</Tabs.Content>
			<Tabs.Content value="json" p="0">
				<JSONView />
			</Tabs.Content>
		</Tabs.Root>
	);
};

export default AstPreview;
