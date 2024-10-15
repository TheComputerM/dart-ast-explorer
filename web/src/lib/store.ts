import { Store } from "@tanstack/solid-store";

export type AstNode =
	| {
			[name: string]: string | boolean | number;
	  }
	| {
			[name: string]: AstNode;
	  }
	| AstNode[];

interface StoreInterface {
	code: string;
	theme: "light" | "dark";
	ast: AstNode;
}

/**
 * Global state for app
 */
export const store = new Store<StoreInterface>({
	code: `void main() {
  for (int i = 0; i < 10; i++) {
    print('hello \${i + 1}');
  }
}`,
	theme: (localStorage.getItem("theme") ?? "light") as StoreInterface["theme"],
	ast: [],
});

(globalThis as any).setAst = (ast: AstNode) => {
	store.setState((state) => ({
		...state,
		ast: Object.values(ast),
	}));
};
