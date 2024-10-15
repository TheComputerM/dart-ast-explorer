import { store } from "~/lib/store";
import { useStore } from "@tanstack/solid-store";

const TreeView = () => {
	const ast = useStore(store, (state) => state.ast);

	console.log(Object.entries(ast));

	return <div>TODO</div>;
};

export default TreeView;
