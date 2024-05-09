import { Flex } from "styled-system/jsx";
import { AstPreview } from "~/components/ast-preview";
import { CodeEditor } from "~/components/code-editor";
import { Navbar } from "~/components/navbar";
import * as Splitter from '~/components/ui/splitter'

function App() {
  return (
    <Flex height="screen" direction="column">
      <Navbar />
      <Splitter.Root size={[
        { id: 'a', size: 50 },
        { id: 'b', size: 50 },
      ]}>
        <Splitter.Panel id="a">
          <CodeEditor />
        </Splitter.Panel>
        <Splitter.ResizeTrigger id="a:b" />
        <Splitter.Panel id="b">
          <AstPreview />
        </Splitter.Panel>
      </Splitter.Root>
    </Flex>
  );
}

export default App;
