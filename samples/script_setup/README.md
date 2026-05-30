## Minimal sample

- `CanvasLayer` is added to as the root node
- `CenterContainer` is added as a child and anchors set to fill the screen
- `Dropdowns` `VBoxContainer` is added as a child and set as Unique for easier access in the script.
- Script is added to the `CanvasLayer`
- `_ready` is used to:
	- Create the dropdowns and add them as child nodes to `Dropdowns` container
	- Populate their items using `add_item`
	- Select the first key using `select`
	- Listen to `item_selected` signal to print the selected ID