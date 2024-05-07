import "@fontsource/roboto";
import { Flex, Grid, GridItem } from "styled-system/jsx";
import { AstPreview } from "~/components/ast-preview";
import { CodeEditor } from "~/components/code-editor";
import { Navbar } from "./components/navbar";

function App() {
  return (
    <Flex height="screen" direction="column">
      <Navbar />
      <Grid flexGrow={1} columns={2}>
        <GridItem>
          <CodeEditor />
        </GridItem>
        <GridItem>
          <AstPreview />
        </GridItem>
      </Grid>
    </Flex>
  );
}

export default App;
