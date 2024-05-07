import { Container, Divider, HStack } from "styled-system/jsx";
import { Heading } from "./ui/heading";
import { IconButton } from "./ui/icon-button";
import { SiGithub } from "solid-icons/si";

export const Navbar = () => (
  <Divider py="1.5">
    <Container>
      <HStack justify="space-between">
        <Heading textStyle="lg">Dart AST Explorer</Heading>
        <HStack>
          <IconButton variant="ghost">
            <SiGithub />
          </IconButton>
        </HStack>
      </HStack>
    </Container>
  </Divider>
)