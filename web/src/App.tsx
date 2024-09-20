import { Suspense, lazy } from "solid-js";
import { Flex } from "styled-system/jsx";
import { CodeEditor } from "~/components/code-editor";
import { Navbar } from "~/components/navbar";
import { Splitter } from '~/components/ui/splitter'

const AstPreview = lazy(() => import("~/components/ast-preview"));

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
          <Suspense fallback={<p>Loading...</p>}>
            <AstPreview />
          </Suspense>
        </Splitter.Panel>
      </Splitter.Root>
    </Flex>
  );
}

export default App;
