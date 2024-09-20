import { IconButton } from "~/components/ui/icon-button";
import { Show, createEffect } from "solid-js";
import { TbMoon, TbSun } from "solid-icons/tb";
import { useStore } from "@tanstack/solid-store";
import { store } from "~/lib/store";

export const ThemeSwitcher = () => {
  const theme = useStore(store, (state) => state.theme);
  createEffect(() => {
    if (theme() === "light") {
      document.documentElement.classList.remove("dark");
    } else {
      document.documentElement.classList.add("dark");
    }
    localStorage.setItem("theme", theme());
  });

  return (
    <IconButton
      variant="outline"
      onClick={() => store.setState((state) => ({ ...state, theme: state.theme === "light" ? "dark" : "light" }))}
    >
      <Show when={theme() === "light"} fallback={<TbSun />}>
        <TbMoon />
      </Show>
    </IconButton>
  );
};
