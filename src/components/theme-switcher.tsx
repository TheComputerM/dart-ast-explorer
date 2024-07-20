import { $theme } from "~/lib/store/theme";
import { IconButton } from "~/components/ui";
import { useStore } from "@nanostores/solid";
import { Show, createEffect } from "solid-js";
import { TbMoon, TbSun } from "solid-icons/tb";

export const ThemeSwitcher = () => {
  const theme = useStore($theme);
  createEffect(() => {
    if (theme() === "light") {
      document.documentElement.classList.remove("dark");
    } else {
      document.documentElement.classList.add("dark");
    }
  });
  return (
    <IconButton
      variant="outline"
      onClick={() => $theme.set(theme() === "light" ? "dark" : "light")}
    >
      <Show when={theme() === "light"} fallback={<TbSun />}>
        <TbMoon />
      </Show>
    </IconButton>
  );
};
