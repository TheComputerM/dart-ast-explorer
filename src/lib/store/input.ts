import { atom } from "nanostores";

const defaultCode = `void main() {
  for (int i = 0; i < 10; i++) {
    print('hello \${i + 1}');
  }
}`;

export const $inputCode = atom<string>(defaultCode);