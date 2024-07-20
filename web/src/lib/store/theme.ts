import { persistentAtom } from '@nanostores/persistent'

export const $theme = persistentAtom<"light" | "dark">("theme", "light");