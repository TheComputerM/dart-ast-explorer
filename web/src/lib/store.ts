import { Store } from "@tanstack/solid-store";


/**
 * Global state for app
 */
export const store = new Store({
    code: `void main() {
  for (int i = 0; i < 10; i++) {
    print('hello \${i + 1}');
  }
}`,
    theme: localStorage.getItem("theme") ?? "light",
    ast: {}
});


(globalThis as any).setAst = (ast: any) => {
  store.setState((state) => ({
    ...state,
    ast
  }))
};
