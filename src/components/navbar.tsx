import { Box, Container, HStack } from "styled-system/jsx";
import { Heading } from "./ui/heading";
import { IconButton } from "./ui/icon-button";
import { SiGithub } from "solid-icons/si";
import { ThemeSwitcher } from "./theme-switcher";

export const Navbar = () => (
  <Box py="1.5">
    <Container>
      <HStack justify="space-between">
        <Heading textStyle="lg">Dart AST Explorer</Heading>
        <HStack>
          <ThemeSwitcher />
          <IconButton variant="ghost" asChild>
            <a href="https://github.com/TheComputerM/dart-ast-explorer" target="_blank">
              <SiGithub />
            </a>
          </IconButton>
        </HStack>
      </HStack>
    </Container>
  </Box>
)