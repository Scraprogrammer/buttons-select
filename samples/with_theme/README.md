## With Theme sample

- This sample is a reproduction from my game.
- A controls structure is created to have a container docked to the top of the screen, with a `ButtonsSelect` attached to the top-left corner with some margins.
- A custom `Theme` is created and attached to the `Control` node, making all child nodes inherit it.
- The `Theme` customizes the `Button` node and adds 3 type variations to be used by `ButtonsSelect`, including variations to visualize selected and unselected items, emulating the way the `OptionButton` looks.
- Text alignment is explicitly set as `Left` on the `ButtonsSelect` and is inherited by the Item buttons, along with the theme.
- White square at the top right corner is set to check that its height does not influence the height of the `ButtonsSelect`.