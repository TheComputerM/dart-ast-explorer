import "@fontsource/roboto";
import { Flex, HStack } from "styled-system/jsx";
import { AstPreview } from "~/components/ast-preview";
import { CodeEditor } from "./components/code-editor";

function App() {
  return (
    <Flex>
      <HStack flexGrow={1} height="screen">
        <CodeEditor />
        <AstPreview />
      </HStack>
    </Flex>
  );
}

export default App;
